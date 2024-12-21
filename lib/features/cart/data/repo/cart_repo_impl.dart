import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/cart/data/data_source/cart_data_source.dart';
import 'package:bluetailor_app/features/cart/data/model/cart_model.dart';
import 'package:bluetailor_app/features/cart/domain/entities/cart_entity.dart';
import 'package:bluetailor_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class CartRepoImpl implements CartRepo {
  final CartDataSource cartDataSource;

  CartRepoImpl({required this.cartDataSource});

  @override
  Future<Either<Failure, String>> removeAlterationToCart(
      {required String itemId}) async {
    try {
      final result =
          await cartDataSource.removeAlterationItemFromCart(itemId: itemId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["removeItemFromAlterationCart"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> fetchAlterationCart() async {
    try {
      final result = await cartDataSource.fetchAlterationCart();

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      if (result.data!["getUserAlterationCart"] == null) {
        return right(CartModel(
            id: "", discTotal: 0, totalAmount: 0, gTotal: 0, items: []));
      }

      return right(CartModel.fromJson(result.data!["getUserAlterationCart"]));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createAlterationOrder(
      {required String cartId, required String addressId}) async {
    try {
      final result = await cartDataSource.createAlterationOrder(
          cartId: cartId, addressId: addressId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["createAlterationOrder"]["orderSrNo"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createStitchingOrder(
      {required String cartId, required String addressId}) async {
    try {
      final result = await cartDataSource.createStitchingOrder(
          cartId: cartId, addressId: addressId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["createStitchingOrder"]["orderSrNo"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> processAlterationOrder(
      {required String orderId, required String razorpayId}) async {
    try {
      final result = await cartDataSource.processAlterationOrder(
          orderId: orderId, razorpayId: razorpayId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!.toString());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> processStitchingOrder(
      {required String orderId, required String razorpayId}) async {
    try {
      final result = await cartDataSource.processStitchingOrder(
          orderId: orderId, razorpayId: razorpayId);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!.toString());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}