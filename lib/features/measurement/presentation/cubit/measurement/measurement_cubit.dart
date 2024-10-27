import 'package:bluetailor_app/features/measurement/domain/usecases/save_measurement_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'measurement_state.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  final SaveMeasurementUsecase _saveMeasurementUsecase;
  MeasurementCubit({required SaveMeasurementUsecase saveMeasurementUsecase})
      : _saveMeasurementUsecase = saveMeasurementUsecase,
        super(MeasurementInitial());

  saveMeasurement(
      {required String catId,
      required String subCat,
      required List<Map<String, dynamic>> options}) async {
    emit(MeasurementLoading());
    final response = await _saveMeasurementUsecase.call(
        params: RequestParam(catId: catId, subCat: subCat, options: options));

    response.fold(
      (l) => emit(MeasurementError(message: l.message)),
      (r) => emit(MeasurementSaved(message: "Your measurement has been saved")),
    );
  }
}
