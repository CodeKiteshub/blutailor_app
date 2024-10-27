import 'package:intl/intl.dart';

class DateEntity {
  final int day;
  final int month;
  final int year;
  final int hour;
  final int minute;
  final String? datestamp;
  final String? timestamp;

  DateEntity(
      {required this.day,
      required this.month,
      required this.year,
      required this.hour,
      required this.minute,
      this.datestamp,
      this.timestamp});

  Map<String, dynamic> toJson() {
    DateTime dateTime = DateTime(year, month, day, hour, minute);
    String yr = DateFormat('yy').format(dateTime);
    String mnth = DateFormat('MM').format(dateTime);
    String date = DateFormat('dd').format(dateTime);
    String hr = DateFormat('HH').format(dateTime);
    String min = DateFormat('mm').format(dateTime);
    final dateStmp = '$year$month$day$hour$minute';

    final timeStmp =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(dateTime.toUtc());
    return <String, dynamic>{
      'day': int.parse(date),
      'month': int.parse(mnth),
      'year': int.parse(yr),
      'hour': int.parse(hr),
      'minute': int.parse(min),
      'datestamp': dateStmp,
      'timestamp': timeStmp,
    };
  }
}
