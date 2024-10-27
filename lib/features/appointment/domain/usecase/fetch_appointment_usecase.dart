import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:bluetailor_app/features/appointment/domain/repo/appointment_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchAppointmentUsecase implements UseCase<List<AppointmentEntity>,void>{
  final AppointmentRepo appointmentRepo;

  FetchAppointmentUsecase({required this.appointmentRepo});
  @override
  Future<Either<Failure, List<AppointmentEntity>>> call({void params}) async{
    return await appointmentRepo.fetchAppointments();
  }
}