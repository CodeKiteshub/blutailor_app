

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductEntities {
  dynamic id;
  dynamic pId;
  List<TagEntity> tags;
  dynamic delivery;
  int deliveryDays;
  dynamic disc;
  dynamic discPrice;
  bool isPer;
  dynamic producttypeId;
  dynamic description;
  List<String> images;
  dynamic name;
  int price;
  dynamic title;
  dynamic catId;
  ProductEntities({
    required this.id,
    required this.pId,
    required this.tags,
    required this.delivery,
    required this.deliveryDays,
    required this.disc,
    required this.discPrice,
    required this.isPer,
    required this.producttypeId,
    required this.description,
    required this.images,
    required this.name,
    required this.price,
    required this.title,
    required this.catId,
  });

}

class TagEntity {
  dynamic catTagEntity;
  dynamic image;
  bool isModifiable;
  bool isVisible;
  dynamic label;
  dynamic name;
  dynamic value;

  TagEntity({
    required this.catTagEntity,
    required this.image,
    required this.isModifiable,
    required this.isVisible,
    required this.label,
    required this.name,
    required this.value,
  });

}
