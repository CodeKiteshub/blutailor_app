import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUsecase implements UseCase<void, void> {
  final AuthRepo authRepo;

  LogoutUsecase({required this.authRepo});

  @override
  Future<Either<Failure, void>> call({void params}) async {
    return await authRepo.logout();
  }
}
