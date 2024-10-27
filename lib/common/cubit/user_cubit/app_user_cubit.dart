import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bluetailor_app/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
  String? location;

  Future<void> updateUser(User? user) async {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      location ??= await _trackLocation();
      final updatedUser = user.copyWith(location: location);
      emit(AppUserLoggedIn(updatedUser));
    }
  }

  Future<String?> _trackLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return "";
    String address = "";
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    await Geolocator.getCurrentPosition(locationSettings: locationSettings)
        .then((Position position) async {
      address = await _addressFromLatLng(position.latitude, position.longitude);
      return address;
    }).catchError((e) {
      debugPrint(e);
      return "";
    });
    return address;
  }

  Future<bool> _handleLocationPermission() async {
    String error;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      error = 'Location services are disabled. Please enable the services';
      log(error, name: 'Location Permission Error');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        error = 'Location permissions are denied';
        log(error, name: 'Location Permission Error');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      error =
          'Location permissions are permanently denied, we cannot request permissions.';
      log(error, name: 'Location Permission Error');
      return false;
    }
    return true;
  }

  Future<String> _addressFromLatLng(double lat, double lng) async {
    try {
      var response = await http.get(Uri.parse(
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAL2st0UKWpVQZHfG25vjG7MNNndOkbFmY"));

      var body = jsonDecode(response.body);
      var area = (body["results"][0]["address_components"] as List)
          .firstWhere((element) {
        return element["types"][0] == "locality"; 
      },
      orElse: () => {"long_name" : ""})["long_name"];
      
      if (area == null || area == "") {
        area = (body["results"][0]["address_components"] as List)
            .firstWhere((element) {
          return element["types"][0] == "administrative_area_level_2";
        },orElse: () => {"long_name" : ""}
        )["long_name"];
      }
      return area;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }
}
