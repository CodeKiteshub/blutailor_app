import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUsecase implements UseCase<User, String> {
  final AuthRepo authRepo;

  GetCurrentUserUsecase({required this.authRepo});
  @override
  Future<Either<Failure, User>> call({String? params}) {
    return authRepo.getUser();
  }
}
