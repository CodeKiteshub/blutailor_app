import 'package:bluetailor_app/features/cart/domain/entities/cart_entity.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/fetch_cart_usecase.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/remove_cart_item_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final FetchCartUsecase _fetchCartUsecase;
  final RemoveCartItemUsecase _removeCartItemUsecase;
  CartCubit(
      {required FetchCartUsecase fetchCartUsecase,
      required RemoveCartItemUsecase removeCartItemUsecase})
      : _fetchCartUsecase = fetchCartUsecase,
        _removeCartItemUsecase = removeCartItemUsecase,
        super(CartInitial());
  CartEntity? cart;

  fetchCart() async {
    emit(CartLoading());
    final result = await _fetchCartUsecase();
    result.fold((l) => emit(CartError()), (r) {
      cart = r;
      emit(CartLoaded(cart: r));
    });
  }

  removeItem({required String itemId}) async {
    emit(CartLoading());
    final result = await _removeCartItemUsecase(params: itemId);
    result.fold((l) => emit(CartError()), (r) => fetchCart());
  }
}
