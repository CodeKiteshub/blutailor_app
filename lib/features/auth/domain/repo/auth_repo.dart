import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, String>> loginWithOtp({required String phoneNumber});

  Future<Either<Failure, User>> verifyOtp(
      {required String otp, required String phoneNumber});

  Future<Either<Failure, User>> loginWithPassword(
      {required String phoneNumber, required String password});

  Future<Either<Failure, String>> register(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phoneNumber,
      required String countryCode});

  Future<Either<Failure, String>> resetPassword(
      {required String phoneNumber,
      required String otp,
      required String password});

      Future<Either<Failure, User>> loginWithGoogle();

  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, void>> logout();
}
