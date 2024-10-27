import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:bluetailor_app/features/address/domain/repo/address_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchAddressListUsecase implements UseCase<List<AddressEntity>, void> {
  final AddressRepo addressRepo;

  FetchAddressListUsecase({required this.addressRepo});
  @override
  Future<Either<Failure, List<AddressEntity>>> call({void params}) async{
    return await addressRepo.fetchAddressList();
  }
}