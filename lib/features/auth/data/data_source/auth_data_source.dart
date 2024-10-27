import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/core/errors/exceptions.dart';
import 'package:bluetailor_app/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gq;
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthDataSource {
  Future<String> loginWithOtp({required String phoneNumber});
  Future<UserModel> verifyOtp(
      {required String otp, required String phoneNumber});
  Future<UserModel> loginWithPassword(
      {required String phoneNumber, required String password});
  Future<String> register(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phoneNumber,
      required String countryCode});
  Future<String> resetPassword(
      {required String phoneNumber,
      required String otp,
      required String password});
  Future<UserModel> loginWithGoogle();
  Future<UserModel> getUser();
  void logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient apiClient;
  final SharedPreferences prefs;

  AuthDataSourceImpl({required this.apiClient, required this.prefs});

  static const String userSchema = '''
    _id
    email
    firstName
    fullName
    gender
    lastName
    phone
      images {
        profile
      }
''';

  @override
  Future<String> loginWithOtp({required String phoneNumber}) async {
    try {
      const String query = r'''
        query Query($source: String!) {
          initiateOtpLogin(source: $source)
      }
      ''';

      final Map<String, dynamic> variables = {
        'source': phoneNumber,
      };

      final result =
          await apiClient.queryData(query: query, variable: variables);

      if (result.hasException) {
        throw ServerException(
            result.exception?.graphqlErrors.first.message.toString() ??
                "Invalid phone number or password");
      }
      log(result.data.toString(), name: "loginWithOtp");

      return "Success";
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> verifyOtp(
      {required String otp, required String phoneNumber}) async {
    try {
      const String query = r'''
query ValidateLoginOtp($source: String!, $otp: String!) {
  validateLoginOtp(source: $source, otp: $otp) {
  token
    user {
    ''' +
          userSchema +
          '''
    }
  }
}
      ''';

      final Map<String, dynamic> variables = {
        'source': phoneNumber,
        "otp": otp
      };

      final result =
          await apiClient.queryData(query: query, variable: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }
      if (result.data == null) {
        throw const ServerException("Invalid phone number or password");
      }

      log(result.data!["validateLoginOtp"]["token"], name: "token");
      prefs.setString("token", result.data!['validateLoginOtp']['token']);
      prefs.setString(
          "userId", result.data!['validateLoginOtp']['user']['_id']);
      return UserModel.fromJson(result.data!['validateLoginOtp']['user']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithPassword(
      {required String phoneNumber, required String password}) async {
    try {
      const String query = r'''
query Login($source: String!, $password: String!) {
  login(source: $source, password: $password) {
  token
    user {
    ''' +
          userSchema +
          '''
    }
  }
}
      ''';

      final Map<String, dynamic> variables = {
        'source': phoneNumber,
        "password": password
      };

      final result =
          await apiClient.queryData(query: query, variable: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }
      if (result.data == null) {
        throw const ServerException("Invalid phone number or password");
      }
      //  log(result.data.toString(), name: "loginWithPassword");
      log(result.data!["login"]["token"], name: "token");
      prefs.setString("token", result.data!['login']['token']);
      prefs.setString("userId", result.data!['login']['user']['_id']);
      return UserModel.fromJson(result.data!['login']['user']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> register(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phoneNumber,
      required String countryCode}) async {
    try {
      const String query = r'''
mutation RegisterUser($email: String!, $phone: String!, $countryCode: String!, $password: String!, $firstName: String!, $lastName: String!, $fullName: String!) {
  registerUser(email: $email, phone: $phone, countryCode: $countryCode, password: $password, firstName: $firstName, lastName: $lastName, fullName: $fullName) {
    _id
  }
}
      ''';

      final Map<String, dynamic> variables = {
        "email": email,
        "phone": phoneNumber,
        "countryCode": countryCode,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": "$firstName $lastName"
      };

      final result =
          await apiClient.mutateData(query: query, variable: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }
      if (result.data == null) {
        throw const ServerException("Invalid phone number or password");
      }

      return result.data!['registerUser']['_id'];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> resetPassword(
      {required String phoneNumber,
      required String otp,
      required String password}) async {
    try {
      const String query = r'''
query Query($source: String!, $otp: String!, $newPassword: String!) {
  saveNewPassword(source: $source, otp: $otp, newPassword: $newPassword)
}
      ''';

      final Map<String, dynamic> variables = {
        'source': phoneNumber,
        "otp": otp,
        "newPassword": password
      };

      final result =
          await apiClient.queryData(query: query, variable: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }

      return "Success";
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final userId = prefs.getString("userId") ?? "";
      const String query = r'''
query User($userId: ID!) {
  user(id: $userId) {
    ''' +
          userSchema +
          '''
  }
}
      ''';

      final Map<String, dynamic> variables = {"userId": userId};

      final result =
          await apiClient.queryData(query: query, variable: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }
      if (result.data == null) {
        throw const ServerException("User not found");
      }
      log(result.data.toString(), name: "user");
      return UserModel.fromJson(result.data!['user']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  void logout() {
    prefs.remove("token");
    prefs.remove("userId");
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      gq.QueryResult? result;
      final auth.UserCredential authResult = await _googleAuthentication();
      final auth.User? gUser = authResult.user;
      if (gUser != null) {
        final auth.User currentUser = auth.FirebaseAuth.instance.currentUser!;
        assert(gUser.uid == currentUser.uid);
        if (authResult.additionalUserInfo?.isNewUser ?? false) {
          result =
              await _googleSignup(gUser, authResult.credential!.accessToken!);

          if (result.hasException) {
            throw ServerException(result.exception.toString());
          }

          log(result.data.toString(), name: "signUpWithGoogle");
          return UserModel.fromJson(result.data!['googleSignup']);
        } else {
          result = await _googleLogin(gUser.uid);

          if (result.hasException) {
            throw ServerException(result.exception.toString());
          }

          log(result.data.toString(), name: "loginWithGoogle");
          prefs.setString("token", result.data!['googleLogin']['token']);
          return UserModel.fromJson(result.data!['googleLogin']['user']);
        }
      }

      throw const ServerException("Firebase user not found");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<auth.UserCredential> _googleAuthentication() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    //  await FirebaseAuth.instance.signInWithCredential(credential);
    final auth.UserCredential authResult =
        await auth.FirebaseAuth.instance.signInWithCredential(credential);

    return authResult;
  }

  Future<gq.QueryResult> _googleSignup(auth.User gUser, String token) async {
    const String query = r'''
mutation GoogleSignup($body: GoogleSignupInput!) {
  googleSignup(body: $body) {
    ''' +
        userSchema +
        '''
  }
}
      ''';

    final Map<String, dynamic> variables = {
      "body": {
        "email": gUser.email,
        "firstName": gUser.displayName?.split(" ").first,
        "fullName": gUser.displayName,
        "id": gUser.uid,
        "image": gUser.photoURL,
        "lastName": gUser.displayName?.split(" ").last,
        "name": gUser.displayName,
        "token": token
      }
    };

    return await apiClient.mutateData(query: query, variable: variables);
  }

  Future<gq.QueryResult> _googleLogin(String id) async {
    const String query = r'''
query GoogleLogin($googleId: String!) {
  googleLogin(googleId: $googleId) {
    user {
      ''' +
        userSchema +
        '''
    }
    token
  }
}
      ''';

    final Map<String, dynamic> variables = {"googleId": id};

    return await apiClient.queryData(query: query, variable: variables);
  }
}
