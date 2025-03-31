import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel(
      {required super.landmark,
      required super.phone,
      required super.address,
      required super.pincode,
      required super.city,
      required super.state,
      required super.countryCode,
      required super.country,
      required super.name,
      super.id, required super.email, required super.firstName, required super.lastName});



  Map<String, dynamic> toMap({required String userId}) {
    return <String, dynamic>{
      'landmark': landmark,
      'phone': phone,
      'address1': address,
      'postalCode': pincode,
      'city': city,
      'state': state,
      'countryCode': countryCode,
      'country': country,
      'name': name,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userId': userId,
  
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      landmark: map['landmark'] as String,
      phone: map['phone'] as String,
      address: map['address1'] as String,
      pincode: map['postalCode'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      countryCode: map['countryCode'] as String,
      country: map['country'] as String,
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }
}
