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

  Map<String, dynamic> standardJson = {
    "categories": [
      {
        "name": "Suit",
        "id": "5da7220571762c2a58b27a66",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Lapel Type", "value": "Shawl"},
          {"name": "Button Type", "value": "Designer"},
          {"name": "No Of Buttons", "value": "1 Button"},
          {"name": "Vent Type", "value": "Double Vent"},
          {"name": "Pocket Type", "value": "Jetted Pocket"},
          {"name": "Innerlining Type", "value": "Plain"}
        ]
      },
      {
        "name": "Sherwani",
        "id": "5da7220571762c2a58b27a70",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Button Type", "value": "Designer"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant"},
          {"name": "Innerlining Type", "value": "Designer"}
        ]
      },
      {
        "name": "Pattu Pancha",
        "id": "65d0cb5c77b0fedc13f0dae7",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Length", "value": "Below Knee"},
          {"name": "Button Type", "value": "Plain"},
          {"name": "Bottom Cut Type", "value": "Straight Bottom"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant"},
          {"name": "Astar Type", "value": "With Astar"}
        ]
      },
      {
        "name": "Jodhpuri",
        "id": "5da7220571762c2a58b27a6c",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Button Type", "value": "Designer Buttons"},
          {"name": "Bottom Cut Type", "value": "Round"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant"},
          {"name": "Pocket Type", "value": "Flap"},
          {"name": "Innerlining Type", "value": "Designer"}
        ]
      },
      {
        "name": "Indo-Western",
        "id": "5da7220571762c2a58b27a6f",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Button Type", "value": "Designer"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant"},
          {"name": "Innerlining Type", "value": "Designer"}
        ]
      },
      {
        "name": "Kurta",
        "id": "5da7220571762c2a58b27a6e",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Length", "value": "Below Knee"},
          {"name": "Button Type", "value": "Designer"},
          {"name": "Bottom Cut Type", "value": "Straight Bottom"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant"},
          {"name": "Astar Type", "value": "With Astar"}
        ]
      },
      {
        "name": "Sadris",
        "id": "5da7220571762c2a58b27a6d",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Button Type", "value": "Fabric Buttons"},
          {"name": "Bottom Cut Type", "value": "Straight"},
          {"name": "Innerlining Type", "value": "Designer"}
        ]
      },
      {
        "name": "Blazers",
        "id": "5da7220571762c2a58b27a68",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Back Styling", "value": "Shawl"},
          {"name": "Button Type", "value": "One Button"},
          {"name": "Vent Type", "value": "Double Vent"},
          {"name": "Pocket Type", "value": "Flap Pocket"},
          {"name": "Innerlining Type", "value": "Plain"}
        ]
      },
      {
        "name": "Waistcoats",
        "id": "5da7220571762c2a58b27a6a",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Button Type", "value": "Fabric Buttons"},
          {"name": "Pocket Type", "value": "Without Pockets"},
          {"name": "Innerlining Type", "value": "Designer"}
        ]
      },
      {
        "name": "Shirts",
        "id": "5da7220571762c2a58b27a65",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim"},
          {"name": "Sleeve Type", "value": "Full Hands"},
          {"name": "Collar Type", "value": "Semi Spread"},
          {"name": "Cuff Type", "value": "Single"},
          {"name": "Pocket Type", "value": "without Pocket"},
          {"name": "Front Styling", "value": "Front"},
          {"name": "Back Styling", "value": "No Pleat"}
        ]
      },
      {
        "name": "Trousers",
        "id": "5da7220571762c2a58b27a67",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim Fit"},
          {"name": "Length", "value": "Ankle Length"},
          {"name": "Back Styling", "value": "No Pleat"},
          {"name": "Back Pocket Type", "value": "Single"},
          {"name": "Innerlining Type", "value": "Yes"},
          {"name": "Crease Type", "value": "Centre"}
        ]
      },
      {"name": "Chinos", "id": "5da7220571762c2a58b27a6b", "defaultConfig": []}
    ]
  };

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
