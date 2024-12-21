import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_image_video_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/add_alteration_to_cart_usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_alteraion_signed_url_usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/save_alteration_usecase.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'save_alteration_state.dart';

class SaveAlterationCubit extends Cubit<SaveAlterationState> {
  final FetchAlteraionSignedUrlUsecase _alteraionSignedUrlUsecase;
  final SaveAlterationUsecase _saveAlterationUsecase;
  final AddAlterationToCartUsecase _addAlterationToCartUsecase;
  SaveAlterationCubit(
      {required FetchAlteraionSignedUrlUsecase fetchAlterationSignedUrl,
      required SaveAlterationUsecase saveAlterationUsecase,
      required AddAlterationToCartUsecase addAlterationToCartUsecase})
      : _alteraionSignedUrlUsecase = fetchAlterationSignedUrl,
        _saveAlterationUsecase = saveAlterationUsecase,
        _addAlterationToCartUsecase = addAlterationToCartUsecase,
        super(SaveAlterationInitial());

  List<AlterationImageVideoEntity> imageAndVideo = [];

  saveAlteration(
      {required String catId,
      required String catName,
      required String imgFile,
      required String videoFile,
      required List<AlterationEntity> alterations}) async {
    emit(SaveAlterationLoading());
    String aalterationId = "";
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

    res.fold((l) => emit(SaveAlterationError()), (r) {
      aalterationId = r;
    });

    if (aalterationId != "") {
      final cart = await _addAlterationToCartUsecase.call(
          params: AddAlterationToCartParam(
              catId: catId,
              catName: catName,
              alterationId: aalterationId,
              alterations: alterations));

      cart.fold((l) => emit(SaveAlterationError()), (r) {
        emit(SavedAlteration());
      });
    } else {
      emit(SaveAlterationError());
    }
  }

  uploadImage(String img) async {
    String? signedUrl;
    final path = await _alteraionSignedUrlUsecase.call(
        params: SignedUrlParam(ext: img.split(".").last, type: "USER_IMAGE"));

    path.fold((l) {
      return null;
    }, (r) {
      signedUrl = r["getAlterationImagesSignedUrl__app"]["signedUrl"];
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
