import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/usecase/fetch_alteration_config_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alteration_config_state.dart';

class AlterationConfigCubit extends Cubit<AlterationConfigState> {
  final FetchAlterationConfigUsecase _fetchAlterationConfigUsecase;
  AlterationConfigCubit(
      {required FetchAlterationConfigUsecase fetchAlterationConfigUsecase})
      : _fetchAlterationConfigUsecase = fetchAlterationConfigUsecase,
        super(AlterationConfigInitial());

  List<AlterationEntity> alterations = [];

  fetchConfig({required String catId}) async {
    emit(AlterationConfigLoading());
    final res = await _fetchAlterationConfigUsecase.call(params: catId);

    res.fold((l) => emit(AlterationConfigError()),
        (r) => emit(AlterationConfigLoaded(config: r.firstOrNull?.options ?? [])));
  }
}
