import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class LoginWithOtpUsecase implements UseCase<String, String> {
final AuthRepo authRepo;

  LoginWithOtpUsecase({required this.authRepo});

  @override
  Future<Either<Failure, String>> call({String? params}) async {
    return await authRepo.loginWithOtp(phoneNumber: params!);
  }
}