import 'package:bluetailor_app/features/settings/domain/entities/store_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/usecases/fetch_store_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_order_state.dart';

class StoreOrderCubit extends Cubit<StoreOrderState> {
  final FetchStoreOrderUsecase _fetchStoreOrderUsecase;
  StoreOrderCubit({
    required FetchStoreOrderUsecase fetchStoreOrderUsecase,
  })  : _fetchStoreOrderUsecase = fetchStoreOrderUsecase,
        super(StoreOrderInitial());

  fetchStoreOrder() async {
    emit(StoreOrderLoading());
    final result = await _fetchStoreOrderUsecase.call();
    result.fold((failure) => emit(StoreOrderError()),
        (storeOrders) => emit(StoreOrderLoaded(storeOrders: storeOrders)));
  }
}
