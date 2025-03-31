import 'dart:developer';

import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/common/models/address_model.dart';
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

      return right(result.data!["createAlterationOrder"]["_id"]);
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

      return right(result.data!["createStitchingOrder"]["_id"]);
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
      log(razorpayId, name: "rpay");
      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!.toString());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductCartEntity>> fetchProductCart() async {
    try {
      final result = await cartDataSource.fetchProductCart();

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(ProductCartEntity.fromMap(result.data!["getUserCart"]));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createProductOrder(
      {required String razorpayId,
      required AddressModel address,
      required ProductCartEntity cart}) async {
    try {
      final result = await cartDataSource.createProductOrder(
          razorpayId: razorpayId, address: address, cart: cart);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["createProductOrder"]["_id"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductCartEntity>> validateProductCartCoupon(
      {required String code}) async {
    try {
      final result = await cartDataSource.validateProductCartCoupon(code: code);
      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(ProductCartEntity.fromMap(result.data!["validateCoupons"]));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductCartEntity>> removeProductItemFromCart(
      {required String itemId}) async {
    try {
      final result =
          await cartDataSource.removeProductItemFromCart(itemId: itemId);
      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(
          ProductCartEntity.fromMap(result.data!["removeItemFromCart"]));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
