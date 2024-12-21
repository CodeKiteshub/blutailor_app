import 'package:bluetailor_app/common/entities/cart_item_entity.dart';
import 'package:bluetailor_app/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel(
      {required super.id, required super.totalAmount, required super.items,
      required super.discTotal, required super.gTotal});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      totalAmount: json['totalAmount'],
      discTotal: json['discTotal'],
      gTotal: json['gTotal'],
      items: List<CartItemEntity>.from(
        (json['items']).map<CartItemEntity>(
          (x) => CartItemEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}