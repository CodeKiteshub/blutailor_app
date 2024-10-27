import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/address/domain/repo/address_repo.dart';
import 'package:fpdart/fpdart.dart';

class DeleteAddressUsecase implements UseCase<String, String> {

  final AddressRepo addressRepo;

  DeleteAddressUsecase({required this.addressRepo});

  @override
  Future<Either<Failure, String>> call({String? params}) async{
    return await addressRepo.deleteAddress(id: params!);
  }
  
}