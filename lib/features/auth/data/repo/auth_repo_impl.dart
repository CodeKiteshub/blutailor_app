import 'dart:async';
import 'dart:developer';

import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:bluetailor_app/features/auth/data/models/user_model.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;
  final SharedPreferences prefs;
  AuthRepoImpl({required this.authDataSource, required this.prefs});

  @override
  Future<Either<Failure, String>> loginWithOtp(
      {required String phoneNumber}) async {
    try {
      final result =
          await authDataSource.loginWithOtp(phoneNumber: phoneNumber);
      if (result == "Success") {
        return right(result!);
      } else {
        return left(Failure());
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(
      {required String otp, required String phoneNumber}) async {
    try {
      final result =
          await authDataSource.verifyOtp(phoneNumber: phoneNumber, otp: otp);
      if (result.hasException) {
        return left(Failure(_checkException(result)));
      }

      prefs.setString("token", result.data!['validateLoginOtp']['token']);
      prefs.setString(
          "userId", result.data!['validateLoginOtp']['user']['_id']);
      return right(
          UserModel.fromJson(result.data!['validateLoginOtp']['user']));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithPassword(
      {required String phoneNumber, required String password}) async {
    try {
      final result = await authDataSource.loginWithPassword(
          phoneNumber: phoneNumber, password: password);

      if (result.hasException) {
        return left(Failure(_checkException(result)));
      }

      //  log(result.data.toString(), name: "loginWithPassword");
      log(result.data!["login"]["token"], name: "token");
      prefs.setString("token", result.data!['login']['token']);
      prefs.setString("userId", result.data!['login']['user']['_id']);
      return right(UserModel.fromJson(result.data!['login']['user']));
    } catch (e) {
      return left(Failure(e.toString()));
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
      if (result != null) {
        return right(result);
      } else {
        return left(Failure("Something went wrong"));
      }
    } catch (e) {
      return left(Failure(e.toString()));
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
        return right(result!);
      } else {
        return left(Failure("Something went wrong"));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await authDataSource.getUser();
      if (result != null) {
        return right(result);
      } else {
        return left(Failure("Something went wrong"));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = authDataSource.logout();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      final result = await authDataSource.loginWithGoogle();
      if (result != null) {
        return right(result);
      } else {
        return left(Failure("Something went wrong"));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /// ERROR CHECKER
  _checkException(result) {
    String errorMessage = "";
    if (result.hasException) {
      final List<GraphQLError> errors = result.exception!.graphqlErrors;
      final LinkException? linkException = result.exception!.linkException;
      if (errors.isNotEmpty) {
        for (final GraphQLError error in errors) {
          errorMessage = error.message.toString();
        }
      } else if (linkException != null) {
        if (linkException.originalException is TimeoutException) {
          errorMessage = "Request timed out!";
        } else {
          errorMessage = linkException.originalException.toString() != "null"
              ? linkException.originalException.toString()
              : "Something went wrong!";
        }
      }
    }
    return errorMessage;
  }
}
