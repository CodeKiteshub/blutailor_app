import 'package:bluetailor_app/common/entities/date_entity.dart';


class ProductOrderEntity {
  final String id;
  final double orderTotal;
  final String orderStatus;
  final int orderId;
  final DateEntity orderDate;
  final String razorPayId;
  final List<ProductOrderItemEntity> orderItems;
  

  ProductOrderEntity(
      {required this.id,
      required this.orderTotal,
      required this.orderStatus,
      required this.orderId,
      required this.orderDate,
      required this.razorPayId,
      required this.orderItems,
    });
}

class ProductOrderItemEntity {
  final double itemPrice;
  final String name;
  final String itemId;
  final int qty;
  final List<String> images;

  ProductOrderItemEntity(
      {required this.itemPrice,
      required this.name,
      required this.itemId,
      required this.qty,
      required this.images});
}
