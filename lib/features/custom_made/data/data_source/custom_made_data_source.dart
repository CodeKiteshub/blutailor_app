import 'package:bluetailor_app/core/api/api_client.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CustomMadeDataSource {
  Future<QueryResult> fetchProducts(
      {required String occassionId,
      required String catId,
      required String searchTerm,
      required int page});
  Future<QueryResult> addItemToCart(
      {required String catId,
      required dynamic deliveryDays,
      required dynamic disc,
      required dynamic discPrice,
      required dynamic isPer,
      required dynamic price,
      required String name,
      required String itemId,
      required List<String> images,
      required String producttypeId,
      required int qty,
      required List<SelectedStylingEntity> styles});
}

class CustomMadeDataSourceImpl implements CustomMadeDataSource {
  final ApiClient client;

  CustomMadeDataSourceImpl({required this.client});

  @override
  Future<QueryResult> fetchProducts(
      {required String occassionId,
      required String catId,
      required String searchTerm,
      required int page}) async {
    String productListQuery = r"""
query ProductsFilter($params: ProductFilter!) {
  productsFilter(params: $params) {
        products {
      _id
      secondaryColor {
        color
        label
      }
      pId
      tags {
        catTag
        image
        isModifiable
        isVisible
        label
        name
        value
      }
       fabric {
        name
      }
      cost
      delivery
      deliveryDays
      discPrice
      isPer
      discount
      description
      images
      isAccessory
      name
      price
      qty
      title
      catId
      producttypeId
    }
  }
}
""";

    return await client.queryData(query: productListQuery, variable: {
      "params": {
        "occasionId": occassionId,
        "catIds": catId == "" ? null : catId,
        "isAccessory": false,
        "searchTerm": searchTerm == "" ? null : searchTerm
      },
      "limit": 10,
      "page": page
    });
  }

  @override
  Future<QueryResult<Object?>> addItemToCart(
      {required String catId,
      required deliveryDays,
      required disc,
      required discPrice,
      required isPer,
      required price,
      required String name,
      required String itemId,
      required List<String> images,
      required String producttypeId,
      required int qty,
      required List<SelectedStylingEntity> styles}) async {
    String addItemToCartQuery = r"""
mutation AddItemsToCart($userId: String!, $items: [CartItemInput!]!) {
  addItemsToCart(userId: $userId, items: $items) {
    totalAmount
  }
}
""";

    final variable = {
      "userId": sl<SharedPreferences>().getString("userId"),
      "items": [
        {
          "catId": catId,
          "deliveryDays": deliveryDays,
          "disc": disc,
          "discPrice": discPrice,
          "images": images,
          "isPer": isPer,
          "itemId": itemId,
          "name": name,
          "price": price,
          "producttypeId": producttypeId,
          "qty": 1,
          "styling": {
            "styles": [...styles.map((e) => e.toMap())]
          }
        }
      ]
    };

    return await client.mutateData(
        query: addItemToCartQuery, variable: variable);
  }
}
