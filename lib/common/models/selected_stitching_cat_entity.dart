// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectedStitchingCatEntity {
  String id;
  String label;
  String img;
  int length;
  List<int> completedIndex;
  SelectedStitchingCatEntity({
    required this.id,
    required this.label,
    required this.img,
    required this.length,
    required this.completedIndex
  });

  SelectedStitchingCatEntity copyWith({
    String? id,
    String? label,
    String? img,
    int? length,
    List<int>? completedIndex,
  }) {
    return SelectedStitchingCatEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      img: img ?? this.img,
      length: length ?? this.length,
      completedIndex: [...completedIndex ?? this.completedIndex]

    );
  }
}
