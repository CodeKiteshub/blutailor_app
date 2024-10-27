import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class LoginWithGoogleUsecase implements UseCase<User, void>{
  final AuthRepo authRepo;

  LoginWithGoogleUsecase({required this.authRepo});
  @override
  Future<Either<Failure, User>> call({void params}) async {
    return await authRepo.loginWithGoogle();
  }
}