import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AlterationDataSource {
  Future<QueryResult> fetchAlterationSignedUrl(
      {required String type, required String ext});
  Future<QueryResult> fetchUserMeasurement({required String catId});
  Future<QueryResult> saveAlteration(
      {required String catId,
      required List<Map<String, dynamic>> imageAndVirdeo,
      required List<Map<String, dynamic>> alterations});
  Future<QueryResult> fetchAlterationConfig({required String catId});
}

class AlterationDataSourceImpl implements AlterationDataSource {
  final ApiClient client;

  AlterationDataSourceImpl({required this.client});
  @override
  Future<QueryResult<Object?>> fetchAlterationSignedUrl(
      {required String type, required String ext}) async {
    String alterationSignedUrlSchema = r"""
query GetAlterationImagesSignedUrl__app($extension: String!, $userId: ID!, $pictureVideoType: AlterationPictureTypeInputEnum) {
  getAlterationImagesSignedUrl__app(extension: $extension, userId: $userId, pictureVideoType: $pictureVideoType) {
    s3ImagePath
    imageName
    signedUrl
  }
}
""";

    final variables = {
      "extension": ext,
      "userId": sl<SharedPreferences>().getString("userId"),
      "pictureVideoType": type
    };

    return await client.queryData(
        query: alterationSignedUrlSchema, variable: variables);
  }

  @override
  Future<QueryResult<Object?>> saveAlteration(
      {required String catId,
      required List<Map<String, dynamic>> imageAndVirdeo,
      required List<Map<String, dynamic>> alterations}) async {
    String saveAlterationSchema = r"""
mutation SaveAlteration($body: AlterationInput!) {
  saveAlteration(body: $body) {
    _id
  }
}
""";

    final variables = {
      "body": {
        "userId": sl<SharedPreferences>().getString("userId"),
        "catId": catId,
        "subCat": null,
        "userImageAndVideos": imageAndVirdeo,
        "alterations": alterations
      }
    };

    return await client.mutateData(
        query: saveAlterationSchema, variable: variables);
  }

  @override
  Future<QueryResult<Object?>> fetchAlterationConfig(
      {required String catId}) async {
    String alterationConfigSchema = r"""
query GetProductAlterationConfig($catId: String!, $subCat: String) {
  getProductAlterationConfig(catId: $catId, subCat: $subCat) {
    options {
      videoUrl
      name
      label
    }
    catId
    subCat
  }
}
""";

    final variables = {"catId": catId, "subCat": null};

    return await client.queryData(
        query: alterationConfigSchema, variable: variables);
  }


    @override
  Future<QueryResult<Object?>> fetchUserMeasurement({required String catId}) {
    String userMeasurementSchema = """
query GetUserMeasurements(\$userId: String!, \$catId: String) {
  getUserMeasurements(userId: \$userId, catId: \$catId) {
  subCat
    options {
      value
      label
    }
  }
}
""";

    final variable = {
      "userId": sl<SharedPreferences>().getString("userId") ?? "",
      "catId": catId
    };

    return client.queryData(
        query: userMeasurementSchema, variable: variable);
  }
}
