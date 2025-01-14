// ignore_for_file: void_checks

import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/common/models/signed_url_param.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/body_profile_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_body_profile_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_signed_url_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_user_size_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/save_body_profile_usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/save_standard_sizing_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'body_profile_state.dart';

class BodyProfileCubit extends Cubit<BodyProfileState> {
  final FetchBodyProfileUsecase _fetchBodyProfileUsecase;
  final SaveBodyProfileUsecase _saveBodyProfileUsecase;
  final SaveStandardSizingUsecase _saveStandardSizingUsecase;
  final FetchUserSizeUsecase _fetchUserSizeUsecase;
  final FetchSignedUrlUsecase _fetchSignedUrlUsecase;
  BodyProfileCubit(
      {required FetchBodyProfileUsecase fetchBodyProfileUsecase,
      required SaveBodyProfileUsecase saveBodyProfileUsecase,
      required SaveStandardSizingUsecase saveStandardSizingUsecase,
      required FetchUserSizeUsecase fetchUserSizeUsecase,
      required FetchSignedUrlUsecase fetchSignedUrlUsecase})
      : _fetchBodyProfileUsecase = fetchBodyProfileUsecase,
        _saveBodyProfileUsecase = saveBodyProfileUsecase,
        _saveStandardSizingUsecase = saveStandardSizingUsecase,
        _fetchUserSizeUsecase = fetchUserSizeUsecase,
        _fetchSignedUrlUsecase = fetchSignedUrlUsecase,
        super(BodyProfileState(status: BodyProfileStatus.initial));

  String selectedSize = "";
  String? fitPreferenceId;
  String? shoulderTypeId;
  String? bodyPostureId;
  String? bodyShapeId;
  String? frontImg;
  String? sideImg;
  String? backImg;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchesController = TextEditingController();
  final TextEditingController cmController = TextEditingController();
  final TextEditingController noteController = TextEditingController();


  @override
  Future<void> close() {
    ageController.dispose();
    weightController.dispose();
    feetController.dispose();
    inchesController.dispose();
    cmController.dispose();
    noteController.dispose();
    return super.close();
  }


// Add tracking
  void trackMemory(String point) {
    log('Memory at $point: ${(ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2)} MB');
  }


  void fetchBodyProfile() async {
    emit(BodyProfileState(status: BodyProfileStatus.loading));
    final bodyProfile = await _fetchBodyProfileUsecase.call(params: "");
    bodyProfile.fold(
        (l) => emit(BodyProfileState(status: BodyProfileStatus.error)), (r) {
      ageController.text = r.age.toString();
      weightController.text = r.weight.toString();
      feetController.text = r.feet.toString();
      inchesController.text = r.inches.toString();
      cmController.text = r.centimeter.toString();
      fitPreferenceId = r.fitPreferenceId;
      shoulderTypeId = r.shoulderTypeId;
      bodyPostureId = r.bodyPostureId;
      bodyShapeId = r.bodyShapeId;
      frontImg = r.frontPicture;
      sideImg = r.sidePicture;
      backImg = r.backPicture;
      emit(BodyProfileState(bodyProfile: r, status: BodyProfileStatus.loaded));
    });
  }

  void saveBodyProfile(
      {required User user,
      bool? isFeet,
      String? catId,
      String? size,
      String? note,
      String? frontPicture,
      String? backPicture,
      String? sidePicture}) async {
        trackMemory('Before save');
    emit(BodyProfileState(status: BodyProfileStatus.loading));
    String height = "";
    if (isFeet ?? true) {
      height = (int.parse(feetController.text) * 30.48 +
              int.parse(inchesController.text) * 2.54)
          .toStringAsFixed(2);
    } else {
      height = cmController.text;
    }
    final result = await _saveBodyProfileUsecase.call(
        params: BodyProfileParams(
            age: ageController.text,
            bodyPosture: bodyPostureId,
            bodyShape: bodyShapeId,
            countryCode: user.countryCode,
            email: user.email,
            firstName: user.firstName,
            fitPreference: fitPreferenceId!,
            height: height,
            lastName: user.lastName,
            phone: user.phone,
            shoulderType: shoulderTypeId!,
            weight: weightController.text,
            frontPicture: frontImg,
            backPicture: backImg,
            sidePicture: sideImg));
    result.fold((l) => emit(BodyProfileState(status: BodyProfileStatus.error)),
        (r) {
      if (catId != null && size != null) {
        saveStandardSizing(
            catId: catId, size: size, bodyProfileId: r, note: note);
      }
      emit(BodyProfileState(status: BodyProfileStatus.saved));
    });
    trackMemory('After save');
  }

  void saveStandardSizing({
    required String catId,
    required String size,
    required String bodyProfileId,
    String? note,
  }) async {
    emit(BodyProfileState(status: BodyProfileStatus.loading));
    final result = await _saveStandardSizingUsecase.call(
        params: StandardSizingParams(
            catId: catId,
            size: size,
            bodyProfileId: bodyProfileId,
            note: note));
    result.fold((l) => emit(BodyProfileState(status: BodyProfileStatus.error)),
        (r) {
      emit(BodyProfileState(status: BodyProfileStatus.saved));
    });
  }

  void fetchUserSize({required String catId}) async {
    final result = await _fetchUserSizeUsecase.call(params: catId);
    result.fold((l) => log(l.toString()), (r) {
      selectedSize = r.firstWhere(
        (e) => e["catId"] == catId,
        orElse: () => {"size": ""},
      )['size'];
      noteController.text = r.firstWhere(
        (e) => e["catId"] == catId,
        orElse: () => {"note": ""},
      )['note'];
    });
  }

  saveBodyImages(
      {required User user,
      required String front,
      required String back,
      required String side}) async {
    emit(BodyProfileState(status: BodyProfileStatus.loading));

    final frontUrl = front.isEmpty ? null : await uploadFront(front);
    final backUrl = back.isEmpty ? null : await uploadBack(back);
    final sideUrl = side.isEmpty ? null : await uploadSide(side);
    if (frontUrl != null || backUrl != null || sideUrl != null) {
      frontImg = frontUrl ?? frontImg;
      sideImg = sideUrl ?? sideImg;
      backImg = backUrl ?? backImg;
      saveBodyProfile(user: user);
    } else {
      emit(BodyProfileState(status: BodyProfileStatus.imgError));
    }
  }

  Future<String?> uploadFront(String img) async {
    String? signedUrl;
    final path = await _fetchSignedUrlUsecase.call(
        params: SignedUrlParam(ext: img.split(".").last, type: "FrontPicture"));

    path.fold((l) {
      return null;
    }, (r) {
      signedUrl = r["signedUrl"];
    });
    final response = await uploadToAWS(img, signedUrl!);
    return response;
  }

  Future<String?> uploadBack(String img) async {
    String? signedUrl;
    final path = await _fetchSignedUrlUsecase.call(
        params: SignedUrlParam(ext: img.split(".").last, type: "BackPicture"));

    path.fold((l) {
      return null;
    }, (r) {
      signedUrl = r["signedUrl"];
    });
    final response = await uploadToAWS(img, signedUrl!);
   return response;
  }

  Future<String?> uploadSide(String img) async {
    String? signedUrl;
    final path = await _fetchSignedUrlUsecase.call(
        params: SignedUrlParam(ext: img.split(".").last, type: "SidePicture"));

    path.fold((l) {
      return null;
    }, (r) {
      signedUrl = r["signedUrl"];
    });
    final response = await uploadToAWS(img, signedUrl!);
    return response;

  }
}
