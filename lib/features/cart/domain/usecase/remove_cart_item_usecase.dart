import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';


class RemoveCartItemUsecase implements UseCase<String, String>{
  final CartRepo cartRepo;

  RemoveCartItemUsecase({required this.cartRepo});
  @override
  Future<Either<Failure, String>> call({String? params}) async{
    return await cartRepo.removeAlterationToCart(itemId: params!);
  }
}

