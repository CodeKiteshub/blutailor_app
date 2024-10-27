import 'package:bluetailor_app/common/entities/user.dart';

class StylistModel extends StylistEntity {
  StylistModel({required super.name, required super.id});

  factory StylistModel.fromJson(Map<String, dynamic> json) {
    return StylistModel(name: json['name'], id: json['_id']);
  }
}
