import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_user_measurement_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_measurement_state.dart';

class UserMeasurementCubit extends Cubit<UserMeasurementState> {
  final FetchUserMeasurementUsecase _fetchUserMeasurementUsecase;
  UserMeasurementCubit(
      {required FetchUserMeasurementUsecase fetchUserMeasurementUsecase})
      : _fetchUserMeasurementUsecase = fetchUserMeasurementUsecase,
        super(UserMeasurementInitial());

  fetchUserMeasurement({required String catId}) async {
    emit(UserMeasurementLoading());
    final response = await _fetchUserMeasurementUsecase.call(params: catId);

    response.fold((l) => emit(UserMeasurementError(message: l.message)), (r) {
      emit(UserMeasurementLoaded(userAttributes: r.firstOrNull?.options ?? []));
    });
  }
}
