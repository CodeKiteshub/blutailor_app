import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/appointment/data/data_source/appointment_data_source.dart';
import 'package:bluetailor_app/features/appointment/data/model/appointment_model.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:bluetailor_app/features/appointment/domain/repo/appointment_repo.dart';
import 'package:fpdart/fpdart.dart';

class AppointmentRepoImpl implements AppointmentRepo {
  final AppointmentDataSource appointmentDataSource;

  AppointmentRepoImpl({required this.appointmentDataSource});
  @override
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
      Map<String, dynamic>? address}) async {
    try {
      final result = await appointmentDataSource.saveAppointment(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          countryCode: countryCode,
          appointmentType: appointmentType,
          appointmentDate: appointmentDate,
          appointmentSelectedTime: appointmentSelectedTime,
          lookingFor: lookingFor,
          address: address);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["saveAppointment"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> fetchAppointments() async {
    try {
      final result = await appointmentDataSource.fetchAppointments();

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(List<AppointmentModel>.from(result
          .data!["getAllAppointments"]["appointments"]
          .map((e) => AppointmentModel.fromMap(e))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
