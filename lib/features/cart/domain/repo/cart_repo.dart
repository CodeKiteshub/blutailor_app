import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/cart/domain/entities/cart_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CartRepo {

  Future<Either<Failure, String>> removeAlterationToCart(
      {required String itemId});

  Future<Either<Failure, CartEntity>> fetchAlterationCart();
  Future<Either<Failure, String>> createAlterationOrder(
      {required String cartId, required String addressId});
      Future<Either<Failure, String>> processAlterationOrder(
          {required String orderId, required String razorpayId}
      );

  Future<Either<Failure, String>> createStitchingOrder(
      {required String cartId, required String addressId});
  Future<Either<Failure, String>> processStitchingOrder(
      {required String orderId, required String razorpayId});
}
