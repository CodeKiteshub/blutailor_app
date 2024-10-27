import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_image_video_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_alteraion_signed_url_usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/save_alteration_usecase.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'save_alteration_state.dart';

class SaveAlterationCubit extends Cubit<SaveAlterationState> {
  final FetchAlteraionSignedUrlUsecase _alteraionSignedUrlUsecase;
  final SaveAlterationUsecase _saveAlterationUsecase;
  SaveAlterationCubit(
      {required FetchAlteraionSignedUrlUsecase fetchAlterationSignedUrl,
      required SaveAlterationUsecase saveAlterationUsecase})
      : _alteraionSignedUrlUsecase = fetchAlterationSignedUrl,
        _saveAlterationUsecase = saveAlterationUsecase,
        super(SaveAlterationInitial());

  List<AlterationImageVideoEntity> imageAndVideo = [];

  saveAlteration(
      {required String catId,
      required String imgFile,
      required String videoFile,
      required List<AlterationEntity> alterations}) async {
    emit(SaveAlterationLoading());
    if (imgFile.isNotEmpty) {
      await uploadImage(imgFile);
    }
    if (videoFile.isNotEmpty) {
      await uploadVideo(videoFile);
    }

    final res = await _saveAlterationUsecase.call(
        params: SaveAlterationParam(
            catId: catId,
            alterations: alterations,
            imageAndVideo: imageAndVideo));

    res.fold(
        (l) => emit(SaveAlterationError()), (r) => emit(SavedAlteration()));
  }

  uploadImage(String img) async {
    String? signedUrl;
    final path = await _alteraionSignedUrlUsecase.call(
        params: SignedUrlParam(ext: img.split(".").last, type: "USER_IMAGE"));

    path.fold((l) {
      return null;
    }, (r) {
      signedUrl = r["signedUrl"];
    });
    final response = await uploadToAWS(img, signedUrl!);

    imageAndVideo
        .add(AlterationImageVideoEntity(isVideo: false, url: response ?? ""));
  }

  uploadVideo(String video) async {
    String? signedUrl;
    final path = await _alteraionSignedUrlUsecase.call(
        params: SignedUrlParam(ext: video.split(".").last, type: "USER_VIDEO"));

    path.fold((l) {
      return null;
    }, (r) {
      signedUrl = r["signedUrl"];
    });
    final response = await uploadToAWS(video, signedUrl!);

    imageAndVideo
        .add(AlterationImageVideoEntity(isVideo: true, url: response ?? ""));
  }
}
