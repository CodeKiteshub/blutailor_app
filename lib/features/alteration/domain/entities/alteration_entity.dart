// ignore_for_file: public_member_api_docs, sort_constructors_first

class AlterationEntity {
  String label;
  double current;
  double value;

  AlterationEntity(
      {required this.label, required this.value, required this.current});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'label': label,
      'value': value,
    };
  }
}
