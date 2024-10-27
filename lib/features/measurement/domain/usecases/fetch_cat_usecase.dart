import 'package:bluetailor_app/common/entities/product_cat_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchCatUsecase implements UseCase<List<ProductCatEntity>, String> {
  final MeasurementRepo measurementRepo;

  FetchCatUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, List<ProductCatEntity>>> call({void params}) async {
    return await measurementRepo.fetchCategories();
  }
}
