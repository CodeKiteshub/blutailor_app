import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/fetch_product_cart_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/remove_item_from_product_cart.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/validate_product_coupon_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_cart_state.dart';

class ProductCartCubit extends Cubit<ProductCartState> {
  final FetchProductCartUsecase _fetchProductCartUsecase;
  final ValidateProductCouponUsecase _validateProductCouponUsecase;
  final RemoveItemFromProductCart _removeItemFromProductCart;
  ProductCartCubit(
      {required FetchProductCartUsecase fetchProductCart,
      required ValidateProductCouponUsecase validateProductCouponUsecase,
      required RemoveItemFromProductCart removeItemFromProductCart})
      : _fetchProductCartUsecase = fetchProductCart,
        _validateProductCouponUsecase = validateProductCouponUsecase,
        _removeItemFromProductCart = removeItemFromProductCart,
        super(ProductCartInitial());

  ProductCartEntity? cart;

  fetchProductCart() async {
    emit(ProductCartLoading());
    final result = await _fetchProductCartUsecase.call();
    result.fold((failure) => emit(ProductCartError()), (cart) {
      this.cart = cart;
      emit(ProductCartLoaded(cart: cart));
    });
  }

  validateCoupon({required String code}) async {
    emit(ProductCartLoading());
    final result = await _validateProductCouponUsecase.call(params: code);
    result.fold((failure) {
      emit(ProductCartCouponError());
    }, (cart) {
      this.cart = cart;
      emit(ProductCartLoaded(cart: cart));
    });
  }

  removeItemFromCart({required String itemId}) async {
    emit(ProductCartLoading());
    final result = await _removeItemFromProductCart.call(params: itemId);
    result.fold((failure) {
      emit(ProductCartError());
    }, (cart) {
      this.cart = cart;
      emit(ProductCartLoaded(cart: cart));
    });
  }
}
