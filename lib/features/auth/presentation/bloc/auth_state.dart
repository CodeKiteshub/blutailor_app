part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthOtpSent extends AuthState {}

final class AuthSuccess extends AuthState {}

final class ForgotPassword extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

final class PasswordResetDone extends AuthState {}

final class AuthRegisterSuccess extends AuthState {}

final class AuthLoggedOut extends AuthState {}
