import 'package:bluetailor_app/common/entities/user.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/address/data/data_source/address_data_source.dart';
import 'package:bluetailor_app/features/address/data/model/address_model.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:bluetailor_app/features/address/domain/repo/address_repo.dart';
import 'package:fpdart/fpdart.dart';

class AddressRepoImpl implements AddressRepo {
  final AddressDataSource addressDataSource;

  AddressRepoImpl({required this.addressDataSource});

  @override
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
      String? id}) async {
    try {
      final result = await addressDataSource.saveAddress(
          landmark: landmark,
          phone: phone,
          address: address,
          pincode: pincode,
          city: city,
          state: state,
          countryCode: countryCode,
          country: country,
          user: user,
          id: id);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["saveAddress"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> fetchAddressList() async {
    try {
      final result = await addressDataSource.fetchAddressList();

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(List<AddressModel>.from(result.data!["getUserAddresses"]
          .map((e) => AddressModel.fromMap(e))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAddress({required String id}) async {
    try {
      final result = await addressDataSource.deleteAddress(id: id);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["deleteAddress"][0]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
