// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String phone;
  String countryCode;
  String profilePic;
  String location;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phone,
      this.profilePic = "",
      this.countryCode = "91",
      this.location = ""});

  User copyWith(
      {String? id,
      String? email,
      String? firstName,
      String? lastName,
      String? phone,
      String? countryCode,
      String? location,
      String? profilePic}) {
    return User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        countryCode: countryCode ?? this.countryCode,
        location: location ?? this.location,
        profilePic: profilePic ?? this.profilePic);
  }
}

class StylistEntity {
  final dynamic name;
  final dynamic id;

  StylistEntity({required this.name, required this.id});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory StylistEntity.fromMap(Map<String, dynamic> map) {
    return StylistEntity(
      name: map['name'] as dynamic,
      id: map['id'] as dynamic,
    );
  }

  factory StylistEntity.fromJson(String source) =>
      StylistEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
