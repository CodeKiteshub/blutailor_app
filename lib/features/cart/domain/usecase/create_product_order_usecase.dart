import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/common/models/address_model.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class CreateProductOrderUsecase implements UseCase<String, CreateProductOrderParams> {
  final CartRepo cartRepo;
  CreateProductOrderUsecase({required this.cartRepo});
  @override
  Future<Either<Failure, String>> call({CreateProductOrderParams? params}) async {
    return await cartRepo.createProductOrder(
        razorpayId: params!.razorpayId,
        address: params.address,
        cart: params.cart);
  }
}

class CreateProductOrderParams {
  final String razorpayId;
  final AddressModel address;
  final ProductCartEntity cart;

  CreateProductOrderParams(
      {required this.razorpayId, required this.address, required this.cart});
}
