import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AddressRepo {
  Future<Either<Failure, String>> saveAddress(
      {required String landmark,
      required String phone,
      required String address,
      required String pincode,
      required String city,
      required String state,
      required String countryCode,
      required String country,
      required User user,
      String? id});

  Future<Either<Failure, List<AddressEntity>>> fetchAddressList();
  Future<Either<Failure, String>> deleteAddress({required String id});
}
