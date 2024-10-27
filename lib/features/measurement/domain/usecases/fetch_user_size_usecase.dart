import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchUserSizeUsecase
    implements UseCase<List<Map<String, dynamic>>, String> {
  final MeasurementRepo measurementRepo;

  FetchUserSizeUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
      {String? params}) async {
    return await measurementRepo.fetchUserStandardSize(catId: params!);
  }
}
