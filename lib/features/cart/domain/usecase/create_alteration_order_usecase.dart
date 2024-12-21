import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class CreateAlterationOrderUsecase
    implements UseCase<String, CreateOrderParams> {
  final CartRepo cartRepo;

  CreateAlterationOrderUsecase({required this.cartRepo});

  @override
  Future<Either<Failure, String>> call({CreateOrderParams? params}) async {
    return await cartRepo.createAlterationOrder(
        cartId: params!.cartId, addressId: params.addressId);
  }
}

class CreateOrderParams {
  String cartId;
  String addressId;

  CreateOrderParams({required this.cartId, required this.addressId});
}
