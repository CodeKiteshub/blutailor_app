import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/size_chart_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchSizeChartUsecase implements UseCase<List<SizeChartEntity>, String> {
  final MeasurementRepo measurementRepo;

  FetchSizeChartUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, List<SizeChartEntity>>> call({String? params}) async {
    return await measurementRepo.fetchSizeChart(catId: params!);
  }
}
