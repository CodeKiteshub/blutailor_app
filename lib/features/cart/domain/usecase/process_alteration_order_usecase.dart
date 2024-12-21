import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class ProcessAlterationOrderUsecase
    implements UseCase<String, ProcessOrderUsecaseParams> {
  final CartRepo cartRepo;

  ProcessAlterationOrderUsecase({required this.cartRepo});

  @override
  Future<Either<Failure, String>> call(
      {ProcessOrderUsecaseParams? params}) async {
    return await cartRepo.processAlterationOrder(
        orderId: params!.orderId, razorpayId: params.razorpayId);
  }
}

class ProcessOrderUsecaseParams {
  String orderId;
  String razorpayId;

  ProcessOrderUsecaseParams({required this.orderId, required this.razorpayId});
}
