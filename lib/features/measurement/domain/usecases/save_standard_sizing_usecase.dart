import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class SaveStandardSizingUsecase
    implements UseCase<String, StandardSizingParams> {
  final MeasurementRepo measurementRepo;

  SaveStandardSizingUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, String>> call({StandardSizingParams? params}) {
    return measurementRepo.saveStandardSizing(
        catId: params!.catId,
        size: params.size,
        bodyProfileId: params.bodyProfileId,
        note: params.note);
  }
}

class StandardSizingParams {
  final String catId;
  final String size;
  final String bodyProfileId;
  final String? note;
  StandardSizingParams(
      {required this.catId,
      required this.size,
      required this.bodyProfileId,
      this.note});
}
