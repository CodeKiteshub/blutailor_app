// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bluetailor_app/common/entities/cart_item_entity.dart';

class CartEntity {
  dynamic id;
  dynamic totalAmount;
  dynamic gTotal;
  dynamic discTotal;
  List<CartItemEntity> items;
  CartEntity({
    required this.id,
    required this.totalAmount,
    required this.gTotal,
    required this.discTotal,
    required this.items,
  });
}
