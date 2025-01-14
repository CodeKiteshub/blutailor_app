import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/styling_config_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class StitchingRepo {
  Future<Either<Failure, String>> fetchStitchingSignedUrl(
      {required String ext});
  Future<Either<Failure, List<StylingConfigEntity>>> fetchStylingConfig(
      {required String catId});
  Future<Either<Failure, String>> saveStitching(
      {required String catId,
      required String fabricName,
      required String fabricImage,
      required double fabricLength,
      required double fabricWidth,
      required String fabricNote,
      required String stylingNote,
      required List<SelectedStylingEntity> styling});
  Future<Either<Failure, String>> addItemToStitchingCart(
      {required String catId,
      required String stitchingId,
      required String fabricName,
      required String stylingNote,
      required dynamic price,
      required List<SelectedStylingEntity> styling});
}
