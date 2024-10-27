import 'package:bluetailor_app/common/entities/product_cat_entity.dart';
import 'package:bluetailor_app/common/models/product_cat_model.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/measurement/data/data_source/measurement_data_source.dart';
import 'package:bluetailor_app/features/measurement/data/model/body_profile_model.dart';
import 'package:bluetailor_app/common/models/product_config_model.dart';
import 'package:bluetailor_app/features/measurement/data/model/size_chart_model.dart';
import 'package:bluetailor_app/features/measurement/data/model/user_attribute_model.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/body_profile_entity.dart';
import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/size_chart_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/user_attribute_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class MeasurementRepoImpl implements MeasurementRepo {
  final MeasurementDataSource measurementDataSource;

  MeasurementRepoImpl({required this.measurementDataSource});
  @override
  Future<Either<Failure, List<ProductCatEntity>>> fetchCategories() async {
    try {
      final result = await measurementDataSource.fetchOcassions();

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        final productCatList = (result.data!["getAllOccasions"] as List)
            .firstWhere((e) => e["name"] == "products")["categories"];
        return right(List<ProductCatModel>.from(
            productCatList.map((e) => ProductCatModel.fromJson(e))));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserAttributeEntity>>> fetchUserAttribute(
      {required String master}) async {
    try {
      final result =
          await measurementDataSource.fetchUserAttribute(master: master);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(List<UserAttributeEntity>.from(result
            .data!["getUserAttributeMaster"]
            .map((e) => UserAttributeModel.fromJson(e))));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductConfigEntity>>> fetchProductConfig(
      {required String catId}) async {
    try {
      final result =
          await measurementDataSource.fetchProductConfig(catId: catId);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(List<ProductConfigEntity>.from(result
            .data!["getProductMeasurementConfig"]
            .map((e) => ProductConfigModel.fromJson(e))));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductConfigEntity>>> fetchUserMeasurement(
      {required String catId}) async {
    try {
      final result =
          await measurementDataSource.fetchUserMeasurement(catId: catId);

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

  @override
  Future<Either<Failure, String>> saveMeasurement(
      {required String catId,
      required String subCat,
      required List<Map<String, dynamic>> measurements}) async {
    try {
      final result = await measurementDataSource.saveMeasurement(
          catId: catId, subCat: subCat, measurements: measurements);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(result.data!.toString());
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SizeChartEntity>>> fetchSizeChart(
      {required String catId}) async {
    try {
      final result = await measurementDataSource.fetchSizeChart(catId: catId);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(List<SizeChartModel>.from(result
            .data!["getStandardSizeChart"]
            .map((e) => SizeChartModel.fromJson(e))));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BodyProfileEntity>> fetchBodyProfile() async {
    try {
      final result = await measurementDataSource.fetchBodyProfile();

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(
            BodyProfileModel.fromJson(result.data!["getBodyProfile"][0]));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveBodyProfile(
      {required String age,
      required String height,
      required String weight,
      required String fitPreference,
      String? bodyShape,
      String? bodyPosture,
      String? shoulderType,
      required String firstName,
      required String lastName,
      required String countryCode,
      required String email,
      required String phone,
    String? frontPicture,
    String? backPicture,
    String? sidePicture}) async {
    try {
      final result = await measurementDataSource.saveBodyProfile(
          age: int.parse(age),
          height: int.parse(height.split(".").first),
          weight: int.parse(weight),
          fitPreferenceId: fitPreference,
          bodyPostureId: bodyShape,
          bodyShapeId: bodyPosture,
          shoulderTypeId: shoulderType,
          firstName: firstName,
          lastName: lastName,
          countryCode: countryCode,
          email: email,
          phone: phone,
          frontPicture: frontPicture,
          backPicture: backPicture,
          sidePicture: sidePicture);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(result.data!["saveBodyProfile"]["_id"]);
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveStandardSizing(
      {required String catId,
      required String size,
      required String bodyProfileId,
      String? note}) async {
    try {
      final result = await measurementDataSource.saveStandardSizing(
          catId: catId, size: size, bodyProfileId: bodyProfileId, note: note);

      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(result.data!.toString());
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStandardSize(
      {required String catId}) async {
    try {
      final result =
          await measurementDataSource.fetchUserStandardSize(catId: catId);
      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(List<Map<String, dynamic>>.from(
            result.data!["getUserStandardSizing"]));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchSignedURL(
      {required String ext, required String type}) async {
    try {
      final result =
          await measurementDataSource.fetchSignedURL(ext: ext, type: type);
      if (result.hasException) {
        return left(Failure(result.exception!.graphqlErrors.first.message));
      } else {
        return right(result.data!["getBodyProfilePictureImageSignedUrl__app"]);
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
