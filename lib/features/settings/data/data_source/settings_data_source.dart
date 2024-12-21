import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsDataSource {
  Future<QueryResult> editProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String profilePic});
  Future<QueryResult> storeOrder();
  Future<QueryResult> appOrder();
  Future<QueryResult> fetchOrders();
  Future<QueryResult> fetchProfilePictureSignedUrl({required String ext});
}

class SettingsDataSourceImpl implements SettingsDataSource {
  final ApiClient apiClient;
  SettingsDataSourceImpl({required this.apiClient});

  @override
  Future<QueryResult> editProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String profilePic}) async {
    const String query = r'''
mutation UpdateUserProfile($userId: String!, $updateData: UpdateUserProfileInput!) {
  updateUserProfile(userId: $userId, updateData: $updateData)
}
      ''';

    final Map<String, dynamic> variables = {
      "userId": sl<SharedPreferences>().getString('userId'),
      "updateData": {
        "firstName": firstName,
        "email": email,
        "lastName": lastName,
        "phone": phone,
        "images": {"profile": profilePic}
      }
    };

    final result =
        await apiClient.mutateData(query: query, variable: variables);
    return result;
  }

  @override
  Future<QueryResult<Object?>> storeOrder() {
    String storeOrderQuery = r'''
query GetAllStoreOrders($params: StoreProductOrderFilterInputParams!) {
  getAllStoreOrders(params: $params) {
    _id
    orderTotal
    orderStatus
    orderNo
    orderDate {
      day
      month
      year
      hour
      minute
      datestamp
      timestamp
    }
    studioId
    orderItems {
      itemPrice
      itemName
    }
    stylist {
      name
      _id
    }
  }
}
''';

    final Map<String, dynamic> variables = {
      "params": {
        "userId": sl<SharedPreferences>().getString('userId'),
      }
    };

    return apiClient.queryData(query: storeOrderQuery, variable: variables);
  }

  @override
  Future<QueryResult<Object?>> appOrder() {
    String appOrderQuery = r'''
query GetAllUserProductOrders($userId: String!, $page: Int, $limit: Int) {
  getAllUserProductOrders(userId: $userId, page: $page, limit: $limit) {
    _id
    orderTotal
    orderId
    status {
      label
    }
    razorPayId
    items {
      qty
      price
      name
      itemId
      images
    }
  }
}
''';

    final Map<String, dynamic> variables = {
      "userId": sl<SharedPreferences>().getString('userId'),
      "page": 1,
      "limit": 20
    };

    return apiClient.queryData(query: appOrderQuery, variable: variables);
  }

  @override
  Future<QueryResult<Object?>> fetchProfilePictureSignedUrl(
      {required String ext}) async {
    String userProfilePicSignedUrlSchema = r"""
query GetUserProfilePictureImageSignedUrl__app($extension: String!, $userId: ID!) {
  getUserProfilePictureImageSignedUrl__app(extension: $extension, userId: $userId) {
    signedUrl
  }
}
""";

    final Map<String, dynamic> variables = {
      "userId": sl<SharedPreferences>().getString('userId'),
      "extension": ext
    };

    return await apiClient.queryData(
        query: userProfilePicSignedUrlSchema, variable: variables);
  }

  @override
  Future<QueryResult<Object?>> fetchOrders() async {
    String fetchOrdersSchema = r"""
query GetAllUserAlterationOrders($userId: String!, $page: Int, $limit: Int) {
  getAllUserAlterationOrders(userId: $userId, page: $page, limit: $limit) {
    orders {
      isPaid
      razorPayId
      orderTotal
      orderSrNo
      status {
        label
      }
      items {
        stitching {
          styling {
            styles {
              label
              value
            }
          }
          name
        }
        alterations {
          label
          price
        }
      }
      orderDateTime {
        day
        month
        year
        hour
        minute
        datestamp
        timestamp
      }
    }
  }
}
""";

    final variable = {
      "userId": sl<SharedPreferences>().getString('userId'),
      "page": 1,
      "limit": 20
    };
    return await apiClient.queryData(
        query: fetchOrdersSchema, variable: variable);
  }
}
