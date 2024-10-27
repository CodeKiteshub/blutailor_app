

import 'package:bluetailor_app/common/entities/user.dart';

class AddressEntity {
  String landmark;
  String phone;
  String address;
  String pincode;
  String city;
  String state;
  String countryCode;
  String country;
  User? user;
  String? id;
  AddressEntity({
    required this.landmark,
    required this.phone,
    required this.address,
    required this.pincode,
    required this.city,
    required this.state,
    required this.countryCode,
    required this.country,
    this.user,
    this.id,
  });
}
