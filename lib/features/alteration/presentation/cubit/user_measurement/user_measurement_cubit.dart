

import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_user_measurement_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_measurement_state.dart';

class AlterationUserMeasurementCubit extends Cubit<UserMeasurementState> {
  final FetchAlterationUserMeasurementUsecase _fetchUserMeasurementUsecase;
  AlterationUserMeasurementCubit(
      {required FetchAlterationUserMeasurementUsecase fetchUserMeasurementUsecase})
      : _fetchUserMeasurementUsecase = fetchUserMeasurementUsecase,
        super(UserMeasurementInitial());

  fetchUserMeasurement({required String catId}) async {
    emit(UserMeasurementLoading());
    final response = await _fetchUserMeasurementUsecase.call(params: catId);

    response.fold((l) => emit(UserMeasurementLoaded(userAttributes: const [])), (r) {
      emit(UserMeasurementLoaded(userAttributes: r.firstOrNull?.options ?? []));
    });
  }
}