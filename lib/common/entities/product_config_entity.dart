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
  String? videoUrl;
  dynamic value;

  OptionEntity({
    required this.label,
    this.videoUrl,
    this.value,
  });
}
