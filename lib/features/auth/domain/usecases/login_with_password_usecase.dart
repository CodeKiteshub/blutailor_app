import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class LoginWithPasswordUsecase implements UseCase<User, UserParams> {
  final AuthRepo authRepo;

  LoginWithPasswordUsecase({required this.authRepo});
  @override
  Future<Either<Failure, User>> call({UserParams? params}) {
    return authRepo.loginWithPassword(
        phoneNumber: params!.phoneNumber, password: params.password!);
  }
}

class UserParams {
  final String phoneNumber;
  final String? password;
  final String? otp;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? countryCode;
  final String? profilePic;

  UserParams(
      {required this.phoneNumber,
      this.password,
      this.otp,
      this.email,
      this.firstName,
      this.lastName,
      this.countryCode,
      this.profilePic});
}
