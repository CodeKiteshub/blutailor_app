import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:fpdart/fpdart.dart';

class ForgotPasswordUsecase implements UseCase<String, UserParams> {
  final AuthRepo authRepo;

  ForgotPasswordUsecase({required this.authRepo});

  @override
  Future<Either<Failure, String>> call({UserParams? params}) async {
    return await authRepo.resetPassword(
        phoneNumber: params!.phoneNumber,
        otp: params.otp!,
        password: params.password!);
  }
}
