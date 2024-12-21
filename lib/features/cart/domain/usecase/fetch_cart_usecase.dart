import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/entities/cart_entity.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchCartUsecase implements UseCase<CartEntity, void> {
  final CartRepo cartRepo;

  FetchCartUsecase({required this.cartRepo});
  @override
  Future<Either<Failure, CartEntity>> call({void params}) async {
    return await cartRepo.fetchAlterationCart();
  }
}
