import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:fpdart/fpdart.dart';

class VerifyOtpUsecase implements UseCase<User, UserParams> {
  final AuthRepo authRepo;

  VerifyOtpUsecase({required this.authRepo});
  @override
  Future<Either<Failure, User>> call({UserParams? params}) {
    return authRepo.verifyOtp(
        phoneNumber: params!.phoneNumber, otp: params.otp!);
  }
}
