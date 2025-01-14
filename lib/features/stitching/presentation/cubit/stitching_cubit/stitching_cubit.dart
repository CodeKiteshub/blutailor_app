import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/add_item_to_cart_usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/fetch_stitching_signed_url_usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/save_stitching_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stitching_state.dart';

class StitchingCubit extends Cubit<StitchingState> {
  final FetchStitchingSignedUrlUsecase _fetchStitchingSignedUrlUseCase;
  final SaveStitchingUsecase _saveStitchingUsecase;
  final AddItemToCartUsecase _addItemToCartUsecase;
  StitchingCubit(
      {required FetchStitchingSignedUrlUsecase fetchStitchingSignedUrlUseCase,
      required SaveStitchingUsecase saveStitchingUsecase,
      required AddItemToCartUsecase addItemToCartUsecase})
      : _addItemToCartUsecase = addItemToCartUsecase,
        _saveStitchingUsecase = saveStitchingUsecase,
        _fetchStitchingSignedUrlUseCase = fetchStitchingSignedUrlUseCase,
        super(StitchingInitial());

  saveStiching(
      {required String catId,
      required String fabricName,
      required String fabricImage,
      required double fabricLength,
      required double fabricWidth,
      required String fabricNote,
      required String stylingNote,
      required dynamic price,
      required List<SelectedStylingEntity> styling}) async {
    emit(StitchingLoading());
    String imageUrl = "";
    String stitchingId = "";
    if (fabricImage != "") {
      imageUrl = await uploadStitchingImage(fabricImage);
    }
    final res = await _saveStitchingUsecase.call(
        params: StitchingDataModel(
      catId: catId,
      fabricName: fabricName,
      fabricImage: imageUrl,
      fabricLength: fabricLength,
      fabricWidth: fabricWidth,
      fabricNote: fabricNote,
      stylingNote: stylingNote,
      price: price,
      styling: styling,
    ));

    res.fold((l) {
      emit(StitchingError(message: l.message));
    }, (r) {
      stitchingId = r;
    });
    if (stitchingId != "") {
      final cart = await _addItemToCartUsecase.call(
          params: StitchingDataModel(
        stitchingId: stitchingId,
        catId: catId,
        fabricName: fabricName,
        fabricImage: imageUrl,
        fabricLength: fabricLength,
        fabricWidth: fabricWidth,
        fabricNote: fabricNote,
        stylingNote: stylingNote,
        price: price,
        styling: styling,
      ));

      cart.fold((l) => emit(StitchingError(message: l.message)), (r) {
        emit(StitchingSaved());
      });
    } else {
      emit(StitchingError(message: "Something went wrong"));
    }
  }

  uploadStitchingImage(String image) async {
    String? signedUrl;
    final path = await _fetchStitchingSignedUrlUseCase.call(
        params: image.split(".").last);

    path.fold((l) {
      emit(StitchingSignedUrlError());
    }, (r) {
      signedUrl = r;
    });
    final response = await uploadToAWS(image, signedUrl!);
    return response;
  }
}
