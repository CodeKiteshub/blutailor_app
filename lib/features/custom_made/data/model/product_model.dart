import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';

class ProductModel extends ProductEntities {
  ProductModel(
      {required super.id,
      required super.pId,
      required super.tags,
      required super.delivery,
      required super.deliveryDays,
      required super.description,
      required super.images,
      required super.name,
      required super.price,
      required super.title,
      required super.catId,
      required super.disc,
      required super.discPrice,
      required super.isPer,
      required super.producttypeId});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as dynamic,
      pId: map['pId'] as dynamic,
      tags: List<Tag>.from(
        (map['tags'] as List).map<Tag>(
          (x) => Tag.fromJson(x as Map<String, dynamic>),
        ),
      ),
      delivery: map['delivery'] as dynamic,
      deliveryDays: map['deliveryDays'] as int,
      description: map['description'] as dynamic,
      images: (map['images'] as List).map<String>((x) => x as String).toList(),
      name: map['name'] as dynamic,
      price: map['price'] as int,
      title: map['title'] as dynamic,
      catId: map['catId'] as dynamic,
      disc: map['discount'] as dynamic,
      discPrice: map['discPrice'] as dynamic,
      isPer: map['isPer'] as bool,
      producttypeId: map['producttypeId'] as dynamic,
    );
  }
}

class Tag extends TagEntity {
  Tag(
      {required super.catTagEntity,
      required super.image,
      required super.isModifiable,
      required super.isVisible,
      required super.label,
      required super.name,
      required super.value});

  factory Tag.fromJson(Map<dynamic, dynamic> json) => Tag(
        catTagEntity: json["catTagEntity"],
        image: json["image"],
        isModifiable: json["isModifiable"],
        isVisible: json["isVisible"],
        label: json["label"],
        name: json["name"],
        value: json["value"],
      );
}
