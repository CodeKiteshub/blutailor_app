// ignore_for_file: public_member_api_docs, sort_constructors_first
class BodyProfileEntity {
    String id;
  int age;
  String bodyShapeId;
  String bodyPostureId;
  int weight;
  int feet;
  int inches;
  int centimeter ;
  String shoulderTypeId;
  String fitPreferenceId;
  dynamic backPicture;
  dynamic frontPicture;
  dynamic sidePicture;
  BodyProfileEntity({
    required this.id,
    required this.age,
    required this.bodyShapeId,
    required this.bodyPostureId,
    required this.weight,
    required this.feet,
    required this.inches,
    required this.centimeter,
    required this.shoulderTypeId,
    required this.fitPreferenceId,
    required this.backPicture,
    required this.frontPicture,
    required this.sidePicture,
  });
}
