// ignore_for_file: public_member_api_docs, sort_constructors_first

class AlterationEntity {
  String label;
  dynamic name;
  double current;
  double value;
  dynamic price;

  AlterationEntity(
      {required this.label, required this.name, required this.value, required this.current, required this.price});

  Map<String, dynamic> toJson(bool forCart) {
    return <String, dynamic>{
      'label': label,
      "name" : name,
      if(forCart) 'price': price
      else
      'value': value,
    };
  }
}
