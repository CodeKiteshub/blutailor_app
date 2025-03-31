import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';


class RemoveItemFromProductCart implements UseCase<ProductCartEntity, String>{
  final CartRepo cartRepo;

  RemoveItemFromProductCart({required this.cartRepo});
  @override
  Future<Either<Failure, ProductCartEntity>> call({String? params}) async{
    return await cartRepo.removeProductItemFromCart(itemId: params!);
  }
}