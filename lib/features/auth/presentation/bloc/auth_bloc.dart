import 'dart:async';

import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_otp_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithOtpUsecase _loginWithOtpUsecase;
  final LoginWithPasswordUsecase _loginWithPasswordUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final RegisterUsecase _registerUsecase;
  final LoginWithGoogleUsecase _loginWithGoogleUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final LogoutUsecase _logoutUsecase;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required LoginWithOtpUsecase loginWithOtpUsecase,
    required LoginWithPasswordUsecase loginWithPasswordUsecase,
    required VerifyOtpUsecase verifyOtpUsecase,
    required ForgotPasswordUsecase forgotPasswordUsecase,
    required RegisterUsecase registerUsecase,
    required LoginWithGoogleUsecase loginWithGoogleUsecase,
    required GetCurrentUserUsecase getCurrentUserUsecase,
    required LogoutUsecase logoutUsecase,
    required AppUserCubit appUserCubit,
  })  : _loginWithOtpUsecase = loginWithOtpUsecase,
        _loginWithPasswordUsecase = loginWithPasswordUsecase,
        _verifyOtpUsecase = verifyOtpUsecase,
        _forgotPasswordUsecase = forgotPasswordUsecase,
        _registerUsecase = registerUsecase,
        _loginWithGoogleUsecase = loginWithGoogleUsecase,
        _getCurrentUserUsecase = getCurrentUserUsecase,
        _logoutUsecase = logoutUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<LoginWithOtpEvent>(_onLoginWithOtpEvent);
    on<LoginWithPasswordEvent>(_onLoginWithPasswordEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<GoogleLoginEvent>(_googleLoginEvent);
    on<AuthIsLoggedIn>(_onIsLoggedInEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<LoggedInAsGuest>(_onLoggedInAsGuest);
  }

  _onLoggedInAsGuest(LoggedInAsGuest event, Emitter<AuthState> emit) async {
    _emitAuthSuccess(emit,
        User(id: "", email: "", firstName: "Guest", lastName: "", phone: ""));
  }

  _onLoginWithOtpEvent(LoginWithOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginWithOtpUsecase.call(params: event.phoneNumber);
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) {
        if (event.isForgotPassword) {
          emit(ForgotPassword());
        } else {
          emit(AuthOtpSent());
        }
      },
    );
  }

  _onLoginWithPasswordEvent(
      LoginWithPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginWithPasswordUsecase.call(
        params: UserParams(
            phoneNumber: event.phoneNumber, password: event.password));
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => _emitAuthSuccess(emit, user),
    );
  }

  Future<void> _onVerifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _verifyOtpUsecase.call(
        params: UserParams(phoneNumber: event.phoneNumber, otp: event.otp));
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => _emitAuthSuccess(emit, user),
    );
  }

  Future<void> _onForgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _forgotPasswordUsecase.call(
        params: UserParams(
            phoneNumber: event.phoneNumber,
            otp: event.otp,
            password: event.password));
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) => emit(PasswordResetDone()),
    );
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _registerUsecase.call(
        params: UserParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            countryCode: event.countryCode));
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) => emit(AuthRegisterSuccess()),
    );
  }

  _emitAuthSuccess(Emitter emit, User user) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess());
  }

  Future<void> _onIsLoggedInEvent(
      AuthIsLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _getCurrentUserUsecase.call();

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => _emitAuthSuccess(emit, user),
    );
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final result = await _logoutUsecase.call();
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) {
        //  _appUserCubit.updateUser(null);
        emit(AuthLoggedOut());
      },
    );
  }

  FutureOr<void> _googleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    _loginWithGoogleUsecase.call().then((result) {
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => _emitAuthSuccess(emit, user),
      );
    });
  }
}
