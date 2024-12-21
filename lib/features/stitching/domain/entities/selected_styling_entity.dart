import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectedStylingEntity {
  String catTag;
  String name;
  String label;
  String value;
  SelectedStylingEntity({
    required this.catTag,
    required this.name,
    required this.label,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"label": label, "value": value, "catTag": catTag};
  }

  factory SelectedStylingEntity.fromMap(Map<String, dynamic> map) {
    return SelectedStylingEntity(
      catTag: map['catTag'] as String,
      name: map['name'] as String,
      label: map['label'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectedStylingEntity.fromJson(String source) =>
      SelectedStylingEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
