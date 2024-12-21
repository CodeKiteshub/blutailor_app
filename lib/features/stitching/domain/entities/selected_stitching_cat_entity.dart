// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectedStitchingCatEntity {
  String id;
  String label;
  String img;
  int length;
  SelectedStitchingCatEntity({
    required this.id,
    required this.label,
    required this.img,
    required this.length,
  });

  SelectedStitchingCatEntity copyWith({
    String? id,
    String? label,
    String? img,
    int? length,
  }) {
    return SelectedStitchingCatEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      img: img ?? this.img,
      length: length ?? this.length,
    );
  }
}
