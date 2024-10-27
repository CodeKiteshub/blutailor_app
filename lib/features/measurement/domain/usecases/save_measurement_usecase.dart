import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class SaveMeasurementUsecase implements UseCase<String, RequestParam> {
  final MeasurementRepo measurementRepo;

  SaveMeasurementUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, String>> call({RequestParam? params}) async {
    return await measurementRepo.saveMeasurement(
        catId: params!.catId,
        subCat: params.subCat,
        measurements: params.options);
  }
}

class RequestParam {
  final String catId;
  final String subCat;
  final List<Map<String, dynamic>> options;

  RequestParam(
      {required this.catId, required this.subCat, required this.options});
}
