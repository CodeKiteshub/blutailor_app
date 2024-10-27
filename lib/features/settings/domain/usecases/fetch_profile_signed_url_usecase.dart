import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchProfileSignedUrlUsecase implements UseCase<String, SignedUrlParam>{
  final SettingsRepo settingsRepo;

  FetchProfileSignedUrlUsecase({required this.settingsRepo});
  @override
  Future<Either<Failure, String>> call({SignedUrlParam? params}) async {
    return await settingsRepo.fetchProfileSignedUrl(ext: params!.ext);
  } 

}