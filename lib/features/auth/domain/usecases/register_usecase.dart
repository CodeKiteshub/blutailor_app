import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUsecase implements UseCase<String, UserParams> {
  final AuthRepo authRepo;

  RegisterUsecase({required this.authRepo});
  @override
  Future<Either<Failure, String>> call({UserParams? params}) {
    return authRepo.register(
        email: params!.email!,
        firstName: params.firstName!,
        lastName: params.lastName!,
        password: params.password!,
        phoneNumber: params.phoneNumber,
        countryCode: params.countryCode!);
  }
}
