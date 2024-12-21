import 'dart:convert';

import 'package:bluetailor_app/features/stitching/domain/entities/styling_config_entity.dart';

class StylingConfigModel extends StylingConfigEntity {
  StylingConfigModel(
      {required super.label,
      required super.masterName,
      required super.options});


  factory StylingConfigModel.fromMap(Map<String, dynamic> map) {
    return StylingConfigModel(
      label: map['label'] as String,
      masterName: map['masterName'] as String,
      options: List<StylingOptionModel>.from(
        (map['options']).map<StylingOptionModel>(
          (x) => StylingOptionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }


  factory StylingConfigModel.fromJson(String source) =>
      StylingConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class StylingOptionModel extends StylingOptionEntity {
  StylingOptionModel(
      {required super.name, required super.image, required super.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'id': id,
    };
  }

  factory StylingOptionModel.fromMap(Map<String, dynamic> map) {
    return StylingOptionModel(
      name: map['name'] as String,
      image: map['image'] as dynamic,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StylingOptionModel.fromJson(String source) =>
      StylingOptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
