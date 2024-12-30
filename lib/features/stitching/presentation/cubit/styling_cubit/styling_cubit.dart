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
        "price": "7500",
        "id": "5da7220571762c2a58b27a66",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Lapel Type", "value": "Shawl", "masterName":"master_lapeltype"},
          {"name": "Button Type", "value": "Designer", "masterName":"master_buttontype"},
          {"name": "No Of Buttons", "value": "1 Button", "masterName":"master_noofbutton"},
          {"name": "Vent Type", "value": "Double Vent", "masterName":"master_venttype"},
          {"name": "Pocket Type", "value": "Jetted Pocket", "masterName":"master_pockettype"},
          {"name": "Innerlining Type", "value": "Plain", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Sherwani",
        "price": "7500",
        "id": "5da7220571762c2a58b27a70",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Button Type", "value": "Designer", "masterName":"master_buttontype"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant", "masterName":"master_bottom_outfit"},
          {"name": "Innerlining Type", "value": "Designer", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Pattu Pancha",
        "price": "0",
        "id": "65d0cb5c77b0fedc13f0dae7",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Length", "value": "Below Knee", "masterName":"master_productlength"},
          {"name": "Button Type", "value": "Plain", "masterName":"master_buttontype"},
          {"name": "Bottom Cut Type", "value": "Straight Bottom", "masterName":"master_bottomcutype"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant", "masterName":"master_bottom_outfit"},
          {"name": "Astar Type", "value": "With Astar", "masterName":"master_astar"}
        ]
      },
      {
        "name": "Jodhpuri",
        "price": "7000",
        "id": "5da7220571762c2a58b27a6c",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Button Type", "value": "Designer Buttons", "masterName":"master_buttontype"},
          {"name": "Bottom Cut Type", "value": "Round", "masterName":"master_bottomcutype"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant", "masterName":"master_bottom_outfit"},
          {"name": "Pocket Type", "value": "Flap", "masterName":"master_pockettype"},
          {"name": "Innerlining Type", "value": "Designer", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Indo-Western",
        "price": "7500",
        "id": "5da7220571762c2a58b27a6f",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Button Type", "value": "Designer", "masterName":"master_buttontype"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant", "masterName":"master_bottom_outfit"},
          {"name": "Innerlining Type", "value": "Designer", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Kurta",
        "price": "3000",
        "id": "5da7220571762c2a58b27a6e",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Length", "value": "Below Knee","masterName":"master_productlength"},
          {"name": "Button Type", "value": "Designer", "masterName":"master_buttontype"},
          {"name": "Bottom Cut Type", "value": "Straight Bottom", "masterName":"master_bottomcutype"},
          {"name": "Bottom Outfit Type", "value": "Slim Pant", "masterName":"master_bottom_outfit"},
          {"name": "Astar Type", "value": "With Astar", "masterName":"master_astar"}
        ]
      },
      {
        "name": "Sadris",
        "price": "3500",
        "id": "5da7220571762c2a58b27a6d",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Button Type", "value": "Fabric Buttons", "masterName":"master_buttontype"},
          {"name": "Bottom Cut Type", "value": "Straight", "masterName":"master_bottomcutype"},
          {"name": "Innerlining Type", "value": "Designer", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Blazers",
        "price": "6300",
        "id": "5da7220571762c2a58b27a68",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"master_fittype"},
          {"name": "Lapel Type", "value": "Shawl", "masterName":"master_lapeltype"},
          {"name": "Button Type", "value": "One Button", "masterName":"master_buttontype"},
          {"name": "Vent Type", "value": "Double Vent", "masterName":"master_venttype"},
          {"name": "Pocket Type", "value": "Flap Pocket", "masterName":"master_pockettype"},
          {"name": "Innerlining Type", "value": "Plain", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Waistcoats",
        "price": "3500",
        "id": "5da7220571762c2a58b27a6a",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName":"fittype"},
          {"name": "Button Type", "value": "Fabric Buttons", "masterName":"master_buttontype"},
          {"name": "Pocket Type", "value": "Without Pockets", "masterName":"master_pocketype"},
          {"name": "Innerlining Type", "value": "Designer", "masterName":"master_innerliningtype"}
        ]
      },
      {
        "name": "Shirts",
        "price": "1200",
        "id": "5da7220571762c2a58b27a65",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim", "masterName": "master_fittype" },
          {"name": "Sleeve Type", "value": "Full Hands", "masterName": "master_sleevetype"},
          {"name": "Collar Type", "value": "Semi Spread", "masterName":"master_collartype"},
          {"name": "Cuff Type", "value": "Single", "masterName":"master_cufftype"},
          {"name": "Pocket Type", "value": "without Pocket", "masterName":"master_pockettype"},
          {"name": "Front Styling", "value": "Front", "masterName":"master_frontstyling"},
          {"name": "Back Styling", "value": "No Pleat", "masterName":"master_pletattype"}
        ]
      },
      {
        "name": "Trousers",
        "price": "1200",
        "id": "5da7220571762c2a58b27a67",
        "defaultConfig": [
          {"name": "Fit Type", "value": "Slim Fit", "masterName":"master_fittype"},
          {"name": "Length", "value": "Ankle Length", "masterName":"master_productlength"},
          {"name": "Back Styling", "value": "No Pleat", "masterName":"master_pleattype"},
          {"name": "Back Pocket Type", "value": "Single", "masterName":"master_backpockettype"},
          {"name": "Innerlining Type", "value": "Yes", "masterName":"master_innerliningtype"},
          {"name": "Crease Type", "value": "Centre", "masterName":"master_creasetype"}
        ]
      },
      {
        "name": "Chinos",
        "id": "5da7220571762c2a58b27a6b",
        "price": "1200",
        "defaultConfig": []
      }
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
