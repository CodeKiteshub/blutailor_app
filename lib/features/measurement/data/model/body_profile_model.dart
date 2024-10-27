import 'package:bluetailor_app/features/measurement/domain/entities/body_profile_entity.dart';

class BodyProfileModel extends BodyProfileEntity {
  BodyProfileModel(
      {required super.id,
      required super.age,
      required super.bodyShapeId,
      required super.bodyPostureId,
      required super.weight,
      required super.feet,
      required super.inches,
      required super.centimeter,
      required super.shoulderTypeId,
      required super.fitPreferenceId,
      required super.backPicture,
      required super.frontPicture,
      required super.sidePicture});

  factory BodyProfileModel.fromJson(Map<String, dynamic> json) {
    int centimeter = json["height"];
    int feet = centimeter ~/ 30.48;
    int inches = ((centimeter % 30.48) / 2.54).round();
    return BodyProfileModel(
        id: json["_id"],
        age: json["age"],
        bodyShapeId: json["bodyShapeId"],
        bodyPostureId: json["bodyPostureId"],
        weight: json["weight"],
        feet: feet,
        inches: inches,
        centimeter: centimeter,
        shoulderTypeId: json["shoulderTypeId"],
        fitPreferenceId: json["fitPreferenceId"],
        backPicture: json["backPicture"],
        frontPicture: json["frontPicture"],
        sidePicture: json["sidePicture"]);
  }
}
