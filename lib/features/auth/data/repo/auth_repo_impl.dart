import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/exceptions.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl({required this.authDataSource});

  @override
  Future<Either<Failure, String>> loginWithOtp(
      {required String phoneNumber}) async {
    try {
      final result =
          await authDataSource.loginWithOtp(phoneNumber: phoneNumber);
      if (result == "Success") {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(
      {required String otp, required String phoneNumber}) async {
    try {
      final result =
          await authDataSource.verifyOtp(phoneNumber: phoneNumber, otp: otp);
      if (result is! ServerException) {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithPassword(
      {required String phoneNumber, required String password}) async {
    try {
      final result = await authDataSource.loginWithPassword(
          phoneNumber: phoneNumber, password: password);
      if (result is! ServerException) {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> register(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phoneNumber,
      required String countryCode}) async {
    try {
      final result = await authDataSource.register(
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password,
          phoneNumber: phoneNumber,
          countryCode: countryCode);
      if (result is! ServerException) {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {required String phoneNumber,
      required String otp,
      required String password}) async {
    try {
      final result = await authDataSource.resetPassword(
          phoneNumber: phoneNumber, otp: otp, password: password);
      if (result == "Success") {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await authDataSource.getUser();
      if (result is! ServerException) {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = authDataSource.logout();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      final result = await authDataSource.loginWithGoogle();
      if (result is! ServerException) {
        return right(result);
      } else {
        return left(Failure());
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
