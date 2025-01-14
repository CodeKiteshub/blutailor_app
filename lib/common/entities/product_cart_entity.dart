import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductCartEntity {
  dynamic totalAmount;
  dynamic gTotal;
  dynamic discTotal;
  List<ProductCartItemEntity> items;
  ProductCartEntity({
    required this.totalAmount,
    required this.gTotal,
    required this.discTotal,
    required this.items,
  });

  factory ProductCartEntity.fromMap(Map<String, dynamic> map) {
    return ProductCartEntity(
      totalAmount: map['totalAmount'] as dynamic,
      gTotal: map['gTotal'] as dynamic,
      discTotal: map['discTotal'] as dynamic,
      items: List<ProductCartItemEntity>.from(
        (map['items']).map<ProductCartItemEntity>(
          (x) => ProductCartItemEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class ProductCartItemEntity {
  dynamic price;
  int qty;
  dynamic disc;
  dynamic discPrice;
  String name;
  String itemId;
  List<String> images;
  ProductCartItemEntity({
    required this.price,
    required this.qty,
    required this.disc,
    required this.discPrice,
    required this.name,
    required this.itemId,
    required this.images,
  });

  factory ProductCartItemEntity.fromMap(Map<String, dynamic> map) {
    return ProductCartItemEntity(
      price: map['price'] as dynamic,
      qty: map['qty'] as int,
      disc: map['disc'] as dynamic,
      discPrice: map['discPrice'] as dynamic,
      name: map['name'] as String,
      itemId: map['itemId'] as String,
      images: (map['images'] as List).map<String>((x) => x as String).toList(),
    );
  }

  factory ProductCartItemEntity.fromJson(String source) =>
      ProductCartItemEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
