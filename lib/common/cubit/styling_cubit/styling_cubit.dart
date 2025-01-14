import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/styling_config_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/fetch_custom_styling_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'styling_state.dart';

class StylingCubit extends Cubit<StylingState> {
  final FetchCustomStylingUsecase _fetchCustomStylingUsecase;
  StylingCubit({required FetchCustomStylingUsecase fetchCustomStylingUsecase})
      : _fetchCustomStylingUsecase = fetchCustomStylingUsecase,
        super(StylingInitial());
  List<StylingConfigEntity> customStyling = [];
  List<SelectedStylingEntity> selectedStylingList = [];


  fetchStyling({required String catId}) async {
    selectedStylingList = [];
    customStyling = [];
    final res = await _fetchCustomStylingUsecase.call(params: catId);

    res.fold((l) {}, (r) {
      Set<String> uniqueMasterNames = {};
      customStyling = r.where((e) {
        if (!uniqueMasterNames.contains(e.masterName)) {
          uniqueMasterNames.add(e.masterName);
          return true;
        } else {
          return false;
        }
      }).toList();
    });
  }

  saveStyling(String masterName, StylingOptionEntity option) {
    if (selectedStylingList.any((e) => e.catTag == masterName)) {
      selectedStylingList = selectedStylingList.map((e) {
        if (e.catTag == masterName) {
          return SelectedStylingEntity(
              catTag: masterName,
              name: customStyling
                  .firstWhere((e) => e.masterName == masterName)
                  .label,
              label: option.name,
              value: option.id);
        } else {
          return e;
        }
      }).toList();
    } else {
      selectedStylingList.add(SelectedStylingEntity(
          catTag: masterName,
          name:
              customStyling.firstWhere((e) => e.masterName == masterName).label,
          label: option.name,
          value: option.id));
    }
    emit(StylingUpdated());
  }
}
