import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_image_video_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AlterationRepo {
  Future<Either<Failure, Map<String, dynamic>>> fetchAlterationSignedUrl(
      {required String type, required String ext});

  Future<Either<Failure, String>> saveAlteration(
      {required String catId,
      required List<AlterationImageVideoEntity> imageAndVideo,
      required List<AlterationEntity> alterations});
  Future<Either<Failure, List<ProductConfigEntity>>> fetchAlterationConfig(
      {required String catId});
  Future<Either<Failure, List<ProductConfigEntity>>> fetchUserMeasurement(
      {required String catId});
}
