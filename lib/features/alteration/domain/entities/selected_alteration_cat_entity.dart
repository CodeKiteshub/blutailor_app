class SelectedAlterationCatEntity {
  String id;
  String label;
  String img;
  int length;
  SelectedAlterationCatEntity({
    required this.id,
    required this.label,
    required this.img,
    required this.length,
  });

  SelectedAlterationCatEntity copyWith({
    String? id,
    String? label,
    String? img,
    int? length,
  }) {
    return SelectedAlterationCatEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      img: img ?? this.img,
      length: length ?? this.length,
    );
  }
}
