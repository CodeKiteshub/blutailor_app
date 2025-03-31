import 'package:bluetailor_app/common/entities/date_entity.dart';
import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:bluetailor_app/features/appointment/domain/usecase/fetch_appointment_usecase.dart';
import 'package:bluetailor_app/features/appointment/domain/usecase/save_appointment_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final SaveAppointmentUsecase _saveAppointmentUsecase;
  final FetchAppointmentUsecase _fetchAppointmentUsecase;
  AppointmentCubit(
      {required SaveAppointmentUsecase saveAppointmentUsecase,
      required FetchAppointmentUsecase fetchAppointmentsUsecase})
      : _saveAppointmentUsecase = saveAppointmentUsecase,
        _fetchAppointmentUsecase = fetchAppointmentsUsecase,
        super(AppointmentInitial());

  saveAppointment({
    required User user,
    required String lookingFor,
    required String type,
    required DateTime selectedDate,
    Map<String, dynamic>? address
  }) async {
    emit(AppointmentLoading());
    final date = DateEntity(
      day: selectedDate.day,
      month: selectedDate.month,
      year: selectedDate.year,
      hour: selectedDate.hour,
      minute: selectedDate.minute,
    );
    final timeStmp =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(selectedDate.toUtc());

    final res = await _saveAppointmentUsecase.call(
        params: SaveAppointmentParam(
            firstName: user.id,
            lastName: user.lastName,
            email: user.email,
            phone: user.phone,
            countryCode: user.countryCode,
            appointmentType: type,
            appointmentDate: date,
            appointmentSelectedTime: timeStmp,
            lookingFor: lookingFor,
            address: address));

    res.fold((l) => emit(AppointmentError(error: l.message)),
        (r) => emit(AppointmentSaved()));
  }

  fetchAppointment() async {
    emit(AppointmentLoading());
    final res = await _fetchAppointmentUsecase.call();

    res.fold((l) => emit(AppointmentError(error: l.message)),
        (r) => emit(AppointmentLoaded(appointments: r)));
  }
}
