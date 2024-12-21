
// ignore_for_file: public_member_api_docs, sort_constructors_first
class StylingConfigEntity {
  dynamic label;
  dynamic masterName;
  List<StylingOptionEntity> options;
  StylingConfigEntity({
    required this.label,
    required this.masterName,
    required this.options,
  });

}


class StylingOptionEntity {
  dynamic name;
  dynamic image;
  dynamic id;
  StylingOptionEntity({
    required this.name,
    required this.image,
    required this.id,
  });

}
