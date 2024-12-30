import 'package:bluetailor_app/common/entities/product_cat_entity.dart';

class ProductCatModel extends ProductCatEntity {
  ProductCatModel(
      {required super.id,
      required super.name,
      required super.label,
      required super.image,
      required super.personalizeImage});

  factory ProductCatModel.fromJson(Map<String, dynamic> map) {
    return ProductCatModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      label: map['label'] as String,
      image: map['image'] + "?abc",
      personalizeImage: map['personalizeImage'] as dynamic,
    );
  }
}
