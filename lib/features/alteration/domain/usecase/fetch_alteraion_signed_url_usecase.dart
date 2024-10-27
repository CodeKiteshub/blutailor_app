import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/repo/alteration_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchAlteraionSignedUrlUsecase
    implements UseCase<Map<String, dynamic>, SignedUrlParam> {
  final AlterationRepo alterationRepo;

  FetchAlteraionSignedUrlUsecase({required this.alterationRepo});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      {SignedUrlParam? params}) async {
    return await alterationRepo.fetchAlterationSignedUrl(
        type: params!.type, ext: params.ext);
  }
}
