import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/user_attribute_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchUserAttributeUsecase
    implements UseCase<List<UserAttributeEntity>, String> {
  final MeasurementRepo measurementRepo;

  FetchUserAttributeUsecase({required this.measurementRepo});

  @override
  Future<Either<Failure, List<UserAttributeEntity>>> call(
      {String? params}) async {
    return await measurementRepo.fetchUserAttribute(master: params!);
  }
}
