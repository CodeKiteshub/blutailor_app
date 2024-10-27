import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/body_profile_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchBodyProfileUsecase  implements UseCase<BodyProfileEntity, String>{
  final MeasurementRepo measurementRepo;

  FetchBodyProfileUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, BodyProfileEntity>> call({String? params}) async{
    return await measurementRepo.fetchBodyProfile();
  }
}