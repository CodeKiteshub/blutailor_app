import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchUserMeasurementUsecase
    implements UseCase<List<ProductConfigEntity>, String> {
  final MeasurementRepo measurementRepo;

  FetchUserMeasurementUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, List<ProductConfigEntity>>> call(
      {String? params}) async {
    return await measurementRepo.fetchUserMeasurement(catId: params!);
  }
}
