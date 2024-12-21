import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/create_alteration_order_usecase.dart';
import 'package:fpdart/fpdart.dart';


class CreateStitchingOrderUsecase implements UseCase<String, CreateOrderParams>{
  final CartRepo cartRepo;
  CreateStitchingOrderUsecase({required this.cartRepo});

  @override
  Future<Either<Failure, String>> call({CreateOrderParams? params}) async{
    return await cartRepo.createStitchingOrder(
        cartId: params!.cartId, addressId: params.addressId);
  }
 }