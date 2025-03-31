class SelectedAlterationCatEntity {
  String id;
  String label;
  String img;
  int length;
  List<int> completedIndex;
  SelectedAlterationCatEntity({
    required this.id,
    required this.label,
    required this.img,
    required this.length,
   required this.completedIndex
  });

  SelectedAlterationCatEntity copyWith({
    String? id,
    String? label,
    String? img,
    int? length,
    List<int>? completedIndex,
  }) {
    var data = [...completedIndex ?? this.completedIndex];
    return SelectedAlterationCatEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      img: img ?? this.img,
      length: length ?? this.length,
      completedIndex: data
    );
  }
}
