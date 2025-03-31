import 'package:bluetailor_app/features/settings/domain/entities/product_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_product_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_order_state.dart';

class ProductOrderCubit extends Cubit<ProductOrderState> {
  final FetchProductOrderUsecase _fetchProductOrderUsecase;
  ProductOrderCubit({
    required FetchProductOrderUsecase fetchProductOrderUsecase,
  })  : _fetchProductOrderUsecase = fetchProductOrderUsecase,
        super(ProductOrderInitial());

  fetchProductOrder() async {
    emit(ProductOrderLoading());
    final result = await _fetchProductOrderUsecase.call();
    result.fold(
        (failure) => emit(ProductOrderError()),
        (productOrders) =>
            emit(ProductOrderLoaded(productOrders: productOrders)));
  }
}
