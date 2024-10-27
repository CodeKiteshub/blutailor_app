import 'package:bluetailor_app/features/settings/domain/entities/product_order_entity.dart';

class ProductOrderModel extends ProductOrderEntity {
  ProductOrderModel(
      {required super.id,
      required super.orderTotal,
      required super.orderStatus,
      required super.orderId,
      required super.orderDate,
      required super.razorPayId,
      required super.orderItems});

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
        id: json['_id'],
        orderTotal: json['orderTotal'],
        orderStatus: json['orderStatus'],
        orderId: json['orderId'],
        orderDate: json['orderDate'],
        razorPayId: json['razorPayId'],
        orderItems: List<ProductOrderItemModel>.from(
            json['orderItems'].map((x) => ProductOrderItemModel.fromJson(x))));
  }
}


class ProductOrderItemModel extends ProductOrderItemEntity {
  ProductOrderItemModel(
      {required super.itemPrice,
      required super.name,
      required super.itemId,
      required super.qty,
      required super.images});

  factory ProductOrderItemModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderItemModel(
        itemPrice: json['itemPrice'],
        name: json['name'],
        itemId: json['itemId'],
        qty: json['qty'],
        images: List<String>.from(json['images']));
  }
}