import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:bluetailor_app/common/entities/user.dart';

class StoreOrderEntity {
  final String id;
  final dynamic orderTotal;
  final dynamic orderStatus;
  final int orderNo;
  final DateEntity? orderDate;
  final dynamic studioId;
  final List<StoreOrderItemEntity> orderItems;
  final List<StylistEntity> stylist;

  StoreOrderEntity(
      {required this.id,
      required this.orderTotal,
      required this.orderStatus,
      required this.orderNo,
      required this.orderDate,
      required this.studioId,
      required this.orderItems,
      required this.stylist});
}

class StoreOrderItemEntity {
  final dynamic itemPrice;
  final String itemName;

  StoreOrderItemEntity({required this.itemPrice, required this.itemName});
}
