import 'package:bluetailor_app/features/alteration/domain/repo/alteration_repo.dart';
import 'package:fpdart/fpdart.dart';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_image_video_entity.dart';

class SaveAlterationUsecase implements UseCase<String, SaveAlterationParam> {
  final AlterationRepo alterationRepo;

  SaveAlterationUsecase({required this.alterationRepo});
  @override
  Future<Either<Failure, String>> call({SaveAlterationParam? params}) async {
    return await alterationRepo.saveAlteration(
        catId: params!.catId,
        imageAndVideo: params.imageAndVideo,
        alterations: params.alterations);
  }
}

class SaveAlterationParam {
  String catId;
  List<AlterationEntity> alterations;
  List<AlterationImageVideoEntity> imageAndVideo;
  SaveAlterationParam({
    required this.catId,
    required this.alterations,
    required this.imageAndVideo,
  });
}
