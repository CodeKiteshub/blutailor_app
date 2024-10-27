import 'package:bluetailor_app/common/models/date_model.dart';
import 'package:bluetailor_app/common/models/stylist_model.dart';
import 'package:bluetailor_app/features/settings/domain/entities/store_order_entity.dart';

class StoreOrderModel extends StoreOrderEntity {
  StoreOrderModel(
      {required super.id,
      required super.orderTotal,
      required super.orderStatus,
      required super.orderNo,
      required super.orderDate,
      required super.studioId,
      required super.orderItems,
      required super.stylist});

  factory StoreOrderModel.fromJson(Map<String, dynamic> json) {
    return StoreOrderModel(
        id: json['_id'],
        orderTotal: json['orderTotal'],
        orderStatus: json['orderStatus'],
        orderNo: json['orderNo'],
        orderDate: json["orderDate"] == null ? null : DateModel.fromJson(json['orderDate']),
        studioId: json['studioId'],
        orderItems: List<StoreOrderItemModel>.from(
            json['orderItems'].map((x) => StoreOrderItemModel.fromJson(x))),
        stylist: List<StylistModel>.from(
            json['stylist'].map((x) => StylistModel.fromJson(x))));
  }
}

class StoreOrderItemModel extends StoreOrderItemEntity {
  StoreOrderItemModel({required super.itemPrice, required super.itemName});

  factory StoreOrderItemModel.fromJson(Map<String, dynamic> json) {
    return StoreOrderItemModel(
        itemPrice: json['itemPrice'], itemName: json['itemName']);
  }
}
