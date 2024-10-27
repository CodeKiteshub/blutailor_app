import 'package:bluetailor_app/features/measurement/domain/entities/user_attribute_entity.dart';

class UserAttributeModel extends UserAttributeEntity {
  UserAttributeModel(
      {required super.id, required super.name, required super.image});

  factory UserAttributeModel.fromJson(Map<String, dynamic> json) =>
      UserAttributeModel(
          id: json["_id"], name: json["name"], image: json["image"]);
}
