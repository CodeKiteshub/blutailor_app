import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StitchingDataSource {
  Future<QueryResult> fetchStitchingSignedUrl(
      {required String type, required String ext});
  Future<QueryResult> fetchStylingConfig({required String catId});
  Future<QueryResult> saveStitching(
      {required String catId,
      required String fabricName,
      required String fabricImage,
      required double fabricLength,
      required double fabricWidth,
      required String fabricNote,
      required String stylingNote,
      required List<Map<String, dynamic>> styling});
  Future<QueryResult> addItemToStitchingCart(
      {required String catId,
      required String fabricName,
      required String stylingNote,
      required String stitchingId,
      required List<Map<String, dynamic>> styling});
}

class StitchingDataSourceImpl implements StitchingDataSource {
  final ApiClient apiClient;

  StitchingDataSourceImpl({required this.apiClient});
  @override
  Future<QueryResult<Object?>> addItemToStitchingCart(
      {required String catId,
      required String fabricName,
      required String stylingNote,
      required String stitchingId,
      required List<Map<String, dynamic>> styling}) async {
    String addItemToStitchingCartSchema = r'''
mutation AddStitchingItemToAlterationCart($items: [StitchingCartItemInput!]!, $userId: String!) {
  addStitchingItemToAlterationCart(items: $items, userId: $userId) {
    _id
  }
}
''';

    final variable = {
      "items": [
        {
          "userStitchingId": stitchingId,
          "name": fabricName,
          "catId": catId,
          "stitching": {
            "styling": {
              "note": stylingNote,
              "styles": [...styling]
            }
          }
        }
      ],
      "userId": sl<SharedPreferences>().getString("userId"),
    };

    return await apiClient.mutateData(
        query: addItemToStitchingCartSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchStitchingSignedUrl(
      {required String type, required String ext}) async {
    String stitchingSignedUrlSchema = r'''
query GetStitchingFabricImageSignedUrl__app($extension: String!, $userId: ID!) {
  getStitchingFabricImageSignedUrl__app(extension: $extension, userId: $userId) {
    signedUrl
  }
}
''';

    final variable = {
      "extension": ext,
      "userId": sl<SharedPreferences>().getString("userId"),
    };

    return await apiClient.queryData(
        query: stitchingSignedUrlSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchStylingConfig(
      {required String catId}) async {
    String stylingConfigSchema = r'''
query Attributes($catId: String!) {
  getStylingConfig(catId: $catId) {
    attributes {
      label
      masterName
      options {
        name
        image
        _id
      }
    }
  }
}
''';

    final variable = {"catId": catId};

    return await apiClient.queryData(
        query: stylingConfigSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> saveStitching(
      {required String catId,
      required String fabricName,
      required String fabricImage,
      required double fabricLength,
      required double fabricWidth,
      required String fabricNote,
      required String stylingNote,
      required List<Map<String, dynamic>> styling}) async {
    String saveStitchingSchema = r'''
mutation SaveStitching($body: StitchingInput!) {
  saveStitching(body: $body) {
    _id
  }
}
''';

    final variable = {
      "body": {
        "catId": catId,
        "userId": sl<SharedPreferences>().getString("userId"),
        "note": fabricNote,
        "name": fabricName,
        "fabricWidth": fabricWidth,
        "fabricLength": fabricLength,
        "fabricImageUrl": fabricImage,
        "styling": {
          "styles": [...styling],
          "note": stylingNote
        }
      }
    };

    return await apiClient.mutateData(
        query: saveStitchingSchema, variable: variable);
  }
}
