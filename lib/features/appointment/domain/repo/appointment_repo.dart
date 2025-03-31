import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AppointmentRepo {
  Future<Either<Failure, String>> saveAppointment(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String countryCode,
      required String appointmentType,
      required DateEntity appointmentDate,
      required String appointmentSelectedTime,
      required String lookingFor,
      Map<String, dynamic>? address});
      Future<Either<Failure, List<AppointmentEntity>>> fetchAppointments();
}
