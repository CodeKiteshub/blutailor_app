

import 'dart:developer';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/stitching/data/data_source/stitching_data_source.dart';
import 'package:bluetailor_app/features/stitching/data/model/styling_config_model.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/styling_config_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/repo/stitching_repo.dart';
import 'package:fpdart/fpdart.dart';

class StitchingRepoImpl implements StitchingRepo {
  final StitchingDataSource stitchingDataSource;

  StitchingRepoImpl({required this.stitchingDataSource});
  @override
  Future<Either<Failure, String>> fetchStitchingSignedUrl(
      {required String ext}) async {
    try {
      final result = await stitchingDataSource.fetchStitchingSignedUrl(
        type: "",
        ext: ext,
      );

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(
        result.data!["getStitchingFabricImageSignedUrl__app"]["signedUrl"],
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StylingConfigEntity>>> fetchStylingConfig(
      {required String catId}) async {
    try {
      final result = await stitchingDataSource.fetchStylingConfig(catId: catId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(List<StylingConfigModel>.from(result
          .data!["getStylingConfig"]["attributes"]
          .map((e) => StylingConfigModel.fromMap(e))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveStitching(
      {required String catId,
      required String fabricName,
      required String fabricImage,
      required double fabricLength,
      required double fabricWidth,
      required String fabricNote,
      required String stylingNote,
      required List<SelectedStylingEntity> styling}) async {
    try {
      final result = await stitchingDataSource.saveStitching(
          catId: catId,
          fabricName: fabricName,
          fabricImage: fabricImage,
          fabricLength: fabricLength,
          fabricWidth: fabricWidth,
          fabricNote: fabricNote,
          stylingNote: stylingNote,
          styling: [...styling.map((e) => e.toMap())]);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(result.data!["saveStitching"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addItemToStitchingCart(
      {required String catId,
      required String stitchingId,
      required String fabricName,
      required String stylingNote,
      required dynamic price,
      required List<SelectedStylingEntity> styling}) async {
    try {
      var body = {
        "stitchingId": stitchingId,
        "price": price,
        "catId": catId,
        "fabricName": fabricName,
        "stylingNote": stylingNote,
        "styling": [...styling.map((e) => e.toMap())]
      };
      log(body.toString());
      final result = await stitchingDataSource.addItemToStitchingCart(
          catId: catId,
          fabricName: fabricName,
          stylingNote: stylingNote,
          stitchingId: stitchingId,
          price: price,
          styling: [...styling.map((e) => e.toMap())]);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(result.data!["addStitchingItemToAlterationCart"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
