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
      super.id});

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
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }
}
