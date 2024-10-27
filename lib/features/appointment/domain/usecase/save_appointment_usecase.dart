import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:fpdart/fpdart.dart';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/appointment/domain/repo/appointment_repo.dart';

class SaveAppointmentUsecase implements UseCase<String, SaveAppointmentParam> {
  final AppointmentRepo appointmentRepo;

  SaveAppointmentUsecase({required this.appointmentRepo});
  @override
  Future<Either<Failure, String>> call({SaveAppointmentParam? params}) async {
    return await appointmentRepo.saveAppointment(
        firstName: params!.firstName,
        lastName: params.lastName,
        email: params.email,
        phone: params.phone,
        countryCode: params.countryCode,
        appointmentType: params.appointmentType,
        appointmentDate: params.appointmentDate,
        appointmentSelectedTime: params.appointmentSelectedTime,
        lookingFor: params.lookingFor);
  }
}

class SaveAppointmentParam {
  String firstName;
  String lastName;
  String email;
  String phone;
  String countryCode;
  String appointmentType;
  DateEntity appointmentDate;
  String appointmentSelectedTime;
  String lookingFor;
  SaveAppointmentParam({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.appointmentType,
    required this.appointmentDate,
    required this.appointmentSelectedTime,
    required this.lookingFor,
  });
}
