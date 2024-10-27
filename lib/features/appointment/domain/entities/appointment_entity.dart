// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:bluetailor_app/common/entities/user.dart';

class AppointmentEntity {
  String id;
  int appointmentId;
  DateEntity dateRecorded;
  DateEntity appointmentDate;
  String appointmentSelectedTimestamp;
  String appointmentType;
  List<dynamic> lookingFor;
  List<StylistEntity> stylist;

  AppointmentEntity({
    required this.id,
    required this.appointmentId,
    required this.dateRecorded,
    required this.appointmentDate,
    required this.appointmentSelectedTimestamp,
    required this.appointmentType,
    required this.lookingFor,
    required this.stylist,
  });
}
