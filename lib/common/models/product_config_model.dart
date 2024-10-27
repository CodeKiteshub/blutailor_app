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
  Option({required super.label, super.videoUrl, super.value});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        videoUrl: json["videoUrl"],
        value: json["value"],
      );
}
