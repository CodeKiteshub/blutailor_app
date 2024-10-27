import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/common/models/product_config_model.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/alteration/data/data_source/alteration_data_source.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_image_video_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/repo/alteration_repo.dart';
import 'package:fpdart/fpdart.dart';

class AlterationRepoImpl implements AlterationRepo {
  final AlterationDataSource alterationDataSource;

  AlterationRepoImpl({required this.alterationDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchAlterationSignedUrl(
      {required String type, required String ext}) async {
    try {
      final result = await alterationDataSource.fetchAlterationSignedUrl(
          type: type, ext: ext);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveAlteration(
      {required String catId,
      required List<AlterationImageVideoEntity> imageAndVideo,
      required List<AlterationEntity> alterations}) async {
    try {
      final result = await alterationDataSource.saveAlteration(
          catId: catId,
          alterations: [...alterations.map((e) => e.toJson())],
          imageAndVirdeo: [...imageAndVideo.map((e) => e.toJson())]);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["saveAlteration"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductConfigEntity>>> fetchAlterationConfig(
      {required String catId}) async {
    try {
      final result =
          await alterationDataSource.fetchAlterationConfig(catId: catId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(List<ProductConfigModel>.from(result
          .data!["getProductAlterationConfig"]
          .map((e) => ProductConfigModel.fromJson(e))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductConfigEntity>>> fetchUserMeasurement(
      {required String catId}) async {
    try {
      final result =
          await alterationDataSource.fetchUserMeasurement(catId: catId);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(List<ProductConfigModel>.from(result
            .data!["getUserMeasurements"]
            .map((e) => ProductConfigModel.fromJson(e))));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
