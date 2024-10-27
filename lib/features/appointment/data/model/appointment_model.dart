import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/common/models/date_model.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:intl/intl.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel(
      {required super.id,
      required super.appointmentId,
      required super.dateRecorded,
      required super.appointmentDate,
      required super.appointmentSelectedTimestamp,
      required super.appointmentType,
      required super.lookingFor,
      required super.stylist});

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    final timeStamp = DateFormat('E, d MMM yyy HH:mm')
        .format(DateTime.parse(map['appointmentSelectedTimestamp']));
    return AppointmentModel(
      id: map['_id'] as String,
      appointmentId: map['appointmentId'] as int,
      dateRecorded:
          DateModel.fromJson(map['dateRecorded'] as Map<String, dynamic>),
      appointmentDate:
          DateModel.fromJson(map['appointmentDate'] as Map<String, dynamic>),
      appointmentSelectedTimestamp: timeStamp,
      appointmentType: map['appointmentType'] as String,
        lookingFor: map["lookingFor"] == null
            ? []
            : List<String>.from(map["lookingFor"].map((x) => x)),
      stylist: map["stylist"] == []
          ? []
          : List<StylistEntity>.from(
              (map['stylist'] as List).map<StylistEntity>(
                (x) => StylistEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
    );
  }
}
