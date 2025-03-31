part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginWithOtpEvent extends AuthEvent {
  final String phoneNumber;
  final bool isForgotPassword;

  LoginWithOtpEvent({required this.phoneNumber, required this.isForgotPassword});
}

class LoginWithPasswordEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  LoginWithPasswordEvent({required this.phoneNumber, required this.password});
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String phoneNumber;

  VerifyOtpEvent({required this.otp, required this.phoneNumber});
}

class ForgotPasswordEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;
  final String password;

  ForgotPasswordEvent(
      {required this.phoneNumber, required this.otp, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String countryCode;

  RegisterEvent(
      {required this.phoneNumber,
      required this.password,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.countryCode});
}

class GoogleLoginEvent extends AuthEvent {}

class AuthIsLoggedIn extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class LoggedInAsGuest extends AuthEvent {}