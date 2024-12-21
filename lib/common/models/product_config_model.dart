import 'package:bluetailor_app/common/entities/product_config_entity.dart';

class ProductConfigModel extends ProductConfigEntity {
  ProductConfigModel({required super.options, required super.subCat});

  factory ProductConfigModel.fromJson(Map<String, dynamic> json) =>
      ProductConfigModel(
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        subCat: json["subCat"],
      );
}

class Option extends OptionEntity {
  Option({required super.label, super.name, super.videoUrl, super.value, super.price});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        name: json["name"],
        videoUrl: json["videoUrl"],
        value: json["value"],
        price: json["price"]
      );
}
