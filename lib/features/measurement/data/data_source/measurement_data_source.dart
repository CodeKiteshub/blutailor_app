
import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class MeasurementDataSource {
  Future<QueryResult> fetchOcassions();
  Future<QueryResult> fetchUserAttribute({required String master});
  Future<QueryResult> fetchProductConfig({required String catId});
  Future<QueryResult> saveMeasurement(
      {required String catId,
      required String subCat,
      required List<Map<String, dynamic>> measurements});
  Future<QueryResult> fetchUserMeasurement({required String catId});
  Future<QueryResult> fetchSizeChart({required String catId});
  Future<QueryResult> fetchBodyProfile();
  Future<QueryResult> saveBodyProfile({
    required int age,
    String? bodyShapeId,
    String? bodyPostureId,
    required int weight,
    required int height,
    String? shoulderTypeId,
    required String fitPreferenceId,
    required String firstName,
    required String lastName,
    required String countryCode,
    required String email,
    required String phone,
    String? frontPicture,
    String? backPicture,
    String? sidePicture
  });
  Future<QueryResult> saveStandardSizing(
      {required String catId,
      required String size,
      required String bodyProfileId,
      String? note});
  Future<QueryResult> fetchUserStandardSize({required String catId});
  Future<QueryResult> fetchSignedURL(
      {required String ext, required String type});
}

class MeasurementDataSourceImpl implements MeasurementDataSource {
  final ApiClient apiClient;
  final SharedPreferences prefs;

  MeasurementDataSourceImpl({required this.apiClient, required this.prefs});

  @override
  Future<QueryResult<Object?>> fetchOcassions() async {
    String ocassionSchema = """
query GetAllOccasions {
  getAllOccasions {
    name
    _id
    categories {
      name
      label
      _id
      personalizeImage
      image
    }
  }
}
""";


    return await apiClient.queryData(query: ocassionSchema, variable: {});
  }

  @override
  Future<QueryResult<Object?>> fetchUserAttribute(
      {required String master}) async {
    String userAttributeSchema = """
query GetUserAttributeMaster(\$filter: UserAttributeMasterFilter) {
  getUserAttributeMaster(filter: \$filter) {
       image
    _id
    name
    personalizeImage
    note
    color
  }
}
""";

    final variable = {
      "filter": {"masterName": master}
    };

    return await apiClient.queryData(
        query: userAttributeSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchProductConfig({required String catId}) {
    String productMeasurementConfig = """
query GetProductMeasurementConfig(\$catId: String!, \$role: String!) {
  getProductMeasurementConfig(catId: \$catId, role: \$role) {
    options {
      label
      videoUrl
    }
    subCat
  }
}
""";

    final variable = {"catId": catId, "role": "client"};

    return apiClient.queryData(
        query: productMeasurementConfig, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> saveMeasurement(
      {required String catId,
      required String subCat,
      required List<Map<String, dynamic>> measurements}) {
    final userId = prefs.getString("userId") ?? "";

    String saveMeasurementSchema = r"""
mutation SaveUserMeasurement($userMeasurements: UserMeasurementsInput) {
  saveUserMeasurement(userMeasurements: $userMeasurements) {
    _id
  }
}
""";

    final variable = {
      "userMeasurements": {
        "catId": catId,
        "subCat": subCat,
        "userId": userId,
        "updatedOptions": measurements
      }
    };

    return apiClient.mutateData(
        query: saveMeasurementSchema, variable: variable);
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
      "userId": prefs.getString("userId") ?? "",
      "catId": catId
    };

    return apiClient.queryData(
        query: userMeasurementSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchSizeChart({required String catId}) {
    String sizeChartSchema = """
query GetStandardSizeChart(\$catIds: [String]) {
  getStandardSizeChart(catIds: \$catIds) {
    size
    options {
      name
      value
    }
    label
  }
}
""";

    final variable = {"catId": catId};

    return apiClient.queryData(query: sizeChartSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchBodyProfile() {
    String bodyProfileSchema = """
query GetBodyProfile(\$userId: String!) {
  getBodyProfile(userId: \$userId) {
    _id
    age
    bodyShapeId
    bodyPostureId
    weight
    height
    shoulderTypeId
    fitPreferenceId
      backPicture
    frontPicture
    sidePicture
    note
  }
}
""";

    final variable = {"userId": prefs.getString("userId") ?? ""};

    return apiClient.queryData(query: bodyProfileSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> saveBodyProfile({
    required int age,
    String? bodyShapeId,
    String? bodyPostureId,
    required int weight,
    required int height,
    String? shoulderTypeId,
    required String fitPreferenceId,
    required String firstName,
    required String lastName,
    required String countryCode,
    required String email,
    required String phone,
    String? frontPicture,
    String? backPicture,
    String? sidePicture
  }) {
    final userId = prefs.getString("userId") ?? "";

    String saveBodyProfileSchema = r"""
        mutation SaveBodyProfile($basicInfo: UserBodyProfileInput) {
  saveBodyProfile(basicInfo: $basicInfo) {
    _id
  }
}
""";

    final variable = {
      "basicInfo": {
        "age": age,
        "weight": weight,
        "userId": userId,
        "phone": phone,
        "lastName": lastName,
        "height": height,
        "fitPreferenceId": fitPreferenceId,
        "firstName": firstName,
        "email": email,
        "countryCode": countryCode,
        "bodyShapeId": bodyShapeId ?? "5d9784da3563743450ab94a2",
        "bodyPostureId": bodyPostureId ?? "5ebcec7077d4223128f4371f",
        "shoulderTypeId": shoulderTypeId ?? "5ebce96f77d4223128f4371b",
        "backPicture": backPicture,
        "sidePicture": sidePicture,
        "frontPicture": frontPicture
      }
    };

    return apiClient.mutateData(
        query: saveBodyProfileSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> saveStandardSizing(
      {required String catId,
      required String size,
      required String bodyProfileId,
      String? note}) {
    String saveStandardSizingSchema = r"""
mutation SaveUserStandardSizing($body: [StandardSizingInput]!) {
  saveUserStandardSizing(body: $body)
}
""";

    var variable = {
      "body": [
        {
          "bodyProfileId": bodyProfileId,
          "catId": catId,
          "userId": prefs.getString("userId") ?? "",
          "size": size,
          "note": note
        }
      ]
    };

    return apiClient.mutateData(
        query: saveStandardSizingSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchUserStandardSize({required String catId}) {
    String userStandardSizeSchema = """
query GetUserStandardSizing(\$userId: String!,\$catIds: [String]) {
  getUserStandardSizing(userId: \$userId, catIds: \$catIds) {
    size
    label
    catId
    note
  }
}
""";

    final variable = {
      "userId": prefs.getString("userId") ?? "",
      "catId": catId
    };

    return apiClient.queryData(
        query: userStandardSizeSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchSignedURL(
      {required String ext, required String type}) {
    String signedURLSchema = r"""
query GetBodyProfilePictureImageSignedUrl__app($extension: String!, $userId: ID!, $pictureType: BodyProfilePictureTypeInputEnum) {
  getBodyProfilePictureImageSignedUrl__app(extension: $extension, userId: $userId, pictureType: $pictureType) {
    imageName
    s3ImagePath
    signedUrl
  }
}
""";

    final variable = {
      "extension": ext,
      "userId": prefs.getString("userId"),
      "pictureType": type
    };

    return apiClient.queryData(query: signedURLSchema, variable: variable);
  }
}
