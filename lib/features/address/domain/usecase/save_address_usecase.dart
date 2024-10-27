import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:fpdart/fpdart.dart';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/address/domain/repo/address_repo.dart';

class SaveAddressUsecase implements UseCase<String, AddressEntity> {
  final AddressRepo addressRepo;

  SaveAddressUsecase({required this.addressRepo});
  @override
  Future<Either<Failure, String>> call({AddressEntity? params}) async {
    return await addressRepo.saveAddress(
        id: params?.id,
        landmark: params!.landmark,
        phone: params.phone,
        address: params.address,
        pincode: params.pincode,
        city: params.city,
        state: params.state,
        countryCode: params.countryCode,
        country: params.country,
        user: params.user!);
  }
}
