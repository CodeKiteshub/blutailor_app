import 'package:bluetailor_app/common/entities/product_cat_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/body_profile_entity.dart';
import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/size_chart_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/entities/user_attribute_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MeasurementRepo {
  Future<Either<Failure, List<ProductCatEntity>>> fetchCategories();
  Future<Either<Failure, List<UserAttributeEntity>>> fetchUserAttribute(
      {required String master});
  Future<Either<Failure, List<ProductConfigEntity>>> fetchProductConfig(
      {required String catId});
  Future<Either<Failure, List<ProductConfigEntity>>> fetchUserMeasurement(
      {required String catId});
  Future<Either<Failure, String>> saveMeasurement(
      {required String catId,
      required String subCat,
      required List<Map<String, dynamic>> measurements});
  Future<Either<Failure, List<SizeChartEntity>>> fetchSizeChart(
      {required String catId});
  Future<Either<Failure, BodyProfileEntity>> fetchBodyProfile();
  Future<Either<Failure, String>> saveBodyProfile({
    required String age,
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
    String? sidePicture
  });
  Future<Either<Failure, String>> saveStandardSizing(
      {required String catId,
      required String size,
      required String bodyProfileId,
      String? note});
  Future<Either<Failure, List<Map<String, dynamic>>>> fetchUserStandardSize(
      {required String catId});
  Future<Either<Failure, Map<String, dynamic>>> fetchSignedURL(
      {required String ext, required String type});
}
