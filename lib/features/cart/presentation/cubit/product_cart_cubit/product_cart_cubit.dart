import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/features/cart/domain/usecase/fetch_product_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_cart_state.dart';

class ProductCartCubit extends Cubit<ProductCartState> {
  final FetchProductCartUsecase _fetchProductCartUsecase;
  ProductCartCubit({required FetchProductCartUsecase fetchProductCart})
      : _fetchProductCartUsecase = fetchProductCart,
        super(ProductCartInitial());

  fetchProductCart() async {
    emit(ProductCartLoading());
    final result = await _fetchProductCartUsecase.call();
    result.fold((failure) => emit(ProductCartError()),
        (cart) => emit(ProductCartLoaded(cart: cart)));
  }
}
