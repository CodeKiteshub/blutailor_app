
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/repo/stitching_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchStitchingSignedUrlUsecase implements UseCase<String, String>{
  final StitchingRepo stitchingRepo;

  FetchStitchingSignedUrlUsecase({required this.stitchingRepo});
  @override
  Future<Either<Failure, String>> call({String? params}) async {
    return await stitchingRepo.fetchStitchingSignedUrl(ext: params!);
  }
}