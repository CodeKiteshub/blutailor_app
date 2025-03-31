import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gTotal': gTotal,
      'discTotal': discTotal,
      "userId": sl<SharedPreferences>().getString("userId"),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class ProductCartItemEntity {
  dynamic price;
  int qty;
  dynamic disc;
  dynamic discPrice;
  String name;
  String itemId;
  String catId;
  int deliveryDays;
  bool isPer;
  String producttypeId;
  List<String> images;
  ProductCartItemEntity({
    required this.price,
    required this.qty,
    required this.disc,
    required this.discPrice,
    required this.name,
    required this.itemId,
    required this.catId,
    required this.deliveryDays,
    required this.isPer,
    required this.producttypeId,
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
      catId: map['catId'] as String,
      deliveryDays: map['deliveryDays'] as int,
      isPer: map['isPer'],
      producttypeId: map['producttypeId'] as String,
      images: (map['images'] as List).map<String>((x) => x as String).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'qty': qty,
      'disc': disc,
      'discPrice': discPrice,
      'name': name,
      'itemId': itemId,
      'images': images,
      "catId": catId,
      "deliveryDays": deliveryDays,
      "isPer": isPer,
      "producttypeId": producttypeId,
    };
  }

  String toJson() => json.encode(toMap());
}
