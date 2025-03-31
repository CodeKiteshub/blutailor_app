import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/common/models/address_model.dart';
import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CartDataSource {
  Future<QueryResult> removeAlterationItemFromCart({required String itemId});
  Future<QueryResult> fetchAlterationCart();
  Future<QueryResult> createAlterationOrder(
      {required String cartId, required String addressId});
  Future<QueryResult> processAlterationOrder(
      {required String orderId, required String razorpayId});
  Future<QueryResult> createStitchingOrder(
      {required String cartId, required String addressId});
  Future<QueryResult> processStitchingOrder(
      {required String orderId, required String razorpayId});
  Future<QueryResult> fetchProductCart();
  Future<QueryResult> createProductOrder(
      {required String razorpayId,
      required AddressModel address,
      required ProductCartEntity cart});
  Future<QueryResult> validateProductCartCoupon({required String code});
  Future<QueryResult> removeProductItemFromCart({required String itemId});
}

class CartDataSourceImpl implements CartDataSource {
  final ApiClient apiClient;

  CartDataSourceImpl({required this.apiClient});

  @override
  Future<QueryResult<Object?>> removeAlterationItemFromCart(
      {required String itemId}) async {
    String removeItemFromCartSchema = r'''
mutation RemoveItemFromAlterationCart($itemId: String!, $userId: String!) {
  removeItemFromAlterationCart(itemId: $itemId, userId: $userId) {
    _id
  }
}
''';

    final variable = {
      "itemId": itemId,
      "userId": sl<SharedPreferences>().getString("userId")
    };

    return await apiClient.mutateData(
        query: removeItemFromCartSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchAlterationCart() async {
    String cartSchema = r'''
query GetUserAlterationCart($userId: String!) {
  getUserAlterationCart(userId: $userId) {
    totalAmount
    _id
    discTotal
    gTotal
    items {
      _id
      catId
      name
      totalAmount
      stitching {
        name
        styling {
          styles {
            label
            value
          }
        }
      }
      alterations {
        name
        label
        price
      }
    }
  }
}
''';

    final variable = {"userId": sl<SharedPreferences>().getString("userId")};

    return await apiClient.queryData(query: cartSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> createAlterationOrder(
      {required String cartId, required String addressId}) async {
    String createOrderSchema = r'''
mutation CreateAlterationOrder($userId: String!, $addressId: String!, $cartId: String!) {
  createAlterationOrder(userId: $userId, addressId: $addressId, cartId: $cartId) {
    orderSrNo
    _id
  }
}
''';

    final variable = {
      "userId": sl<SharedPreferences>().getString("userId"),
      "addressId": addressId,
      "cartId": cartId
    };

    return await apiClient.mutateData(
        query: createOrderSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> processAlterationOrder(
      {required String orderId, required String razorpayId}) async {
    String processOrderSchema = r'''
mutation ProcessAlterationOrderPayment($orderId: ID!, $razorpayIntentId: String!) {
  processAlterationOrderPayment(orderId: $orderId, razorpayIntentId: $razorpayIntentId) {
    firstName
  }
}
''';

    final variable = {"orderId": orderId, "razorpayIntentId": razorpayId};

    return await apiClient.mutateData(
        query: processOrderSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> createStitchingOrder(
      {required String cartId, required String addressId}) async {
    String createStitchingOrderSchema = r'''
mutation CreateStitchingOrder($userId: String!, $addressId: String!, $cartId: String!) {
  createStitchingOrder(userId: $userId, addressId: $addressId, cartId: $cartId) {
    orderSrNo
    _id
  }
}
''';

    final variable = {
      "userId": sl<SharedPreferences>().getString("userId"),
      "addressId": addressId,
      "cartId": cartId
    };

    return await apiClient.mutateData(
        query: createStitchingOrderSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> processStitchingOrder(
      {required String orderId, required String razorpayId}) async {
    String processOrderSchema = r'''
mutation ProcessStitchingOrderPayment($orderId: ID!, $razorpayIntentId: String!) {
  processStitchingOrderPayment(orderId: $orderId, razorpayIntentId: $razorpayIntentId) {
    firstName
  }
}
''';

    final variable = {"orderId": orderId, "razorpayIntentId": razorpayId};

    return await apiClient.mutateData(
        query: processOrderSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> fetchProductCart() async {
    String cartSchema = r'''
query GetUserCart($userId: String!) {
  getUserCart(userId: $userId) {
    discTotal
    gTotal
    totalAmount
    items {
      price
      name
      qty
      itemId
      images
      discPrice
      disc
      catId
      deliveryDays
      isPer
      producttypeId
    }
  }
}
''';

    return await apiClient.queryData(
        query: cartSchema,
        variable: {"userId": sl<SharedPreferences>().getString("userId")});
  }

  @override
  Future<QueryResult<Object?>> createProductOrder(
      {required String razorpayId,
      required AddressModel address,
      required ProductCartEntity cart}) async {
    String createOrderSchema = r'''
mutation CreateProductOrder($order: ProductOrderInput!) {
  createProductOrder(order: $order) {
    _id
  }
}
''';

    final variable = {
      "order": {
        "razorPayId": razorpayId,
        "address":
            address.toMap(userId: sl<SharedPreferences>().getString("userId") ?? ""),
        "cart": cart.toMap()
      }
    };

    return await apiClient.mutateData(
        query: createOrderSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> validateProductCartCoupon(
      {required String code}) async {
    String validateCouponSchema = r'''
query ValidateCoupons($userId: String!, $couponcode: String!) {
  validateCoupons(userId: $userId, couponcode: $couponcode) {
    discTotal
    gTotal
    totalAmount
    items {
      price
      name
      qty
      itemId
      images
      discPrice
      disc
      catId
      deliveryDays
      isPer
      producttypeId
    }
  }
}
''';

    final variable = {
      "userId": sl<SharedPreferences>().getString("userId"),
      "couponcode": code
    };

    return await apiClient.mutateData(
        query: validateCouponSchema, variable: variable);
  }

  @override
  Future<QueryResult<Object?>> removeProductItemFromCart(
      {required String itemId}) async {
    String removeItemFromCartSchema = r'''
mutation RemoveItemFromCart($itemId: String!, $userId: String!) {
  removeItemFromCart(itemId: $itemId, userId: $userId) {
        discTotal
    gTotal
    totalAmount
    items {
      price
      name
      qty
      itemId
      images
      discPrice
      disc
      catId
      deliveryDays
      isPer
      producttypeId
    }
  }
}
''';

    final variable = {
      "itemId": itemId,
      "userId": sl<SharedPreferences>().getString("userId")
    };

    return await apiClient.mutateData(
        query: removeItemFromCartSchema, variable: variable);
  }
}
