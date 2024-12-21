import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/process_alteration_order_usecase.dart';
import 'package:fpdart/fpdart.dart';


class ProcessStitchingOrderUsecase implements UseCase<String, ProcessOrderUsecaseParams>{
  final CartRepo cartRepo;
  ProcessStitchingOrderUsecase({required this.cartRepo});
  @override
  Future<Either<Failure, String>> call({ProcessOrderUsecaseParams? params}) async{
    return await cartRepo.processStitchingOrder(
        orderId: params!.orderId, razorpayId: params.razorpayId);
  }
}