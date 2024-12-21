import 'package:bluetailor_app/common/entities/cart_item_entity.dart';
import 'package:bluetailor_app/common/models/date_model.dart';
import 'package:bluetailor_app/features/settings/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required super.isPaid,
      required super.orderSrNo,
      required super.orderTotal,
      required super.razorPayId,
      required super.status,
      required super.orderDateTime,
      required super.items});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      isPaid: json['isPaid'],
      orderSrNo: json['orderSrNo'],
      orderTotal: json['orderTotal'],
      razorPayId: json['razorPayId'],
      status: (json['status'] as List).last['label'],
      orderDateTime: DateModel.fromJson(json['orderDateTime']),
      items: List<CartItemEntity>.from(
        (json['items']).map<CartItemEntity>(
          (x) => CartItemEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
