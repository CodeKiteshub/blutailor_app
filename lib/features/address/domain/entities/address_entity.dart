// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  String name;
  String email;
  String firstName;
  String lastName;
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
    required this.name,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.user,
    this.id,
  });

}
