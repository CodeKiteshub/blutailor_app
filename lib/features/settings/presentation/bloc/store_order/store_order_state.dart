part of 'store_order_cubit.dart';

sealed class StoreOrderState extends Equatable {
  const StoreOrderState();

  @override
  List<Object> get props => [];
}

final class StoreOrderInitial extends StoreOrderState {}

final class StoreOrderLoaded extends StoreOrderState {
  final List<StoreOrderEntity> storeOrders;

  const StoreOrderLoaded({required this.storeOrders});
}

final class StoreOrderError extends StoreOrderState {}

final class StoreOrderLoading extends StoreOrderState {}