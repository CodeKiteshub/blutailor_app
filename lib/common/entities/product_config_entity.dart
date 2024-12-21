// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductConfigEntity {
    List<OptionEntity> options;
  dynamic subCat;
  ProductConfigEntity({
    required this.options,
    required this.subCat,
  });
}

class OptionEntity {
  dynamic label;
  dynamic name;
  String? videoUrl;
  dynamic value;
  dynamic price;

  OptionEntity({
    required this.label,
    this.name,
    this.videoUrl,
    this.value,
    this.price
  });
}
