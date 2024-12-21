// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bluetailor_app/common/entities/cart_item_entity.dart';
import 'package:bluetailor_app/common/entities/date_entity.dart';

class OrderEntity {
  bool isPaid;
  String orderSrNo;
  dynamic orderTotal;
  dynamic razorPayId;
  String status;
  DateEntity orderDateTime;
  List<CartItemEntity> items;
  OrderEntity({
    required this.isPaid,
    required this.orderSrNo,
    required this.orderTotal,
    required this.razorPayId,
    required this.status,
    required this.orderDateTime,
    required this.items,
  });
}
