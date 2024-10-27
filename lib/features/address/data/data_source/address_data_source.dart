import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AddressDataSource {
  Future<QueryResult> saveAddress(
      {required String landmark,
      required String phone,
      required String address,
      required String pincode,
      required String city,
      required String state,
      required String countryCode,
      required String country,
      required User user,
      String? id});
  Future<QueryResult> fetchAddressList();
  Future<QueryResult> deleteAddress({required String id});
}

class AddressDataSourceImpl implements AddressDataSource {
  final ApiClient apiClient;

  AddressDataSourceImpl({required this.apiClient});

  @override
  Future<QueryResult<Object?>> saveAddress(
      {required String landmark,
      required String phone,
      required String address,
      required String pincode,
      required String city,
      required String state,
      required String countryCode,
      required String country,
      required User user,
      String? id}) async {
    String saveAddressSchema = r"""
mutation SaveAddress($address: UserAddressInput!) {
  saveAddress(address: $address) {
    _id
  }
}
""";

    final variable = {
      "address": {
        "_id": id,
        "address1": address,
        "city": city,
        "country": country,
        "countryCode": countryCode,
        "email": user.email,
        "firstName": user.firstName,
        "landmark": landmark,
        "lastName": user.lastName,
        "phone": phone,
        "postalCode": pincode,
        "state": state,
        "userId": sl<SharedPreferences>().getString("userId"),
      }
    };

    return await apiClient.mutateData(
        query: saveAddressSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchAddressList() async {
    String fetchAddressSchema = r"""
query GetUserAddresses($userId: String!) {
  getUserAddresses(userId: $userId) {
    _id
    address1
    phone
    state
    postalCode
    landmark
    country
    city
    countryCode
  }
}
""";

    final variable = {
      "userId": sl<SharedPreferences>().getString("userId"),
    };

    return await apiClient.queryData(
        query: fetchAddressSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> deleteAddress({required String id}) async {
    String deleteAddressSchema = r"""
mutation DeleteAddress($addressId: String!, $userId: String!) {
  deleteAddress(addressId: $addressId, userId: $userId) {
    _id
  }
}
""";

    final variable = {
      "addressId": id,
      "userId": sl<SharedPreferences>().getString("userId")
    };

    return await apiClient.mutateData(
        query: deleteAddressSchema, variable: variable);
  }
}
