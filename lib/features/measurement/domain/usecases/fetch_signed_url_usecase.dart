import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchSignedUrlUsecase
    implements UseCase<Map<String, dynamic>, SignedUrlParam> {
  final MeasurementRepo measurementRepo;

  FetchSignedUrlUsecase({required this.measurementRepo});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      {SignedUrlParam? params}) async {
    return await measurementRepo.fetchSignedURL(
        ext: params!.ext, type: params.type);
  }
}

