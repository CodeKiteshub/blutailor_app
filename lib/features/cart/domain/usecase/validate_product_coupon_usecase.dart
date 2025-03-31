import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class ValidateProductCouponUsecase
    implements UseCase<ProductCartEntity, String> {
  final CartRepo cartRepo;

  ValidateProductCouponUsecase({required this.cartRepo});
  @override
  Future<Either<Failure, ProductCartEntity>> call({String? params}) {
    return cartRepo.validateProductCartCoupon(code: params!);
  }
}
