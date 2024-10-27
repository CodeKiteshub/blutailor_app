import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:intl/intl.dart';

class DateModel extends DateEntity {
  DateModel(
      {required super.day,
      required super.month,
      required super.year,
      required super.hour,
      required super.minute,
      required super.datestamp,
      required super.timestamp});

  factory DateModel.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime(json["year"], json["month"], json["day"], json["hour"], json["minute"]);
    final timeStamp = DateFormat('E, d MMM yyy HH:mm')
        .format(date);
    return DateModel(
        day: json['day'],
        month: json['month'],
        year: json['year'],
        hour: json['hour'],
        minute: json['minute'],
        datestamp: json['datestamp'],
        timestamp: timeStamp);
  }
}
