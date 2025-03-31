part of 'product_order_cubit.dart';

sealed class ProductOrderState extends Equatable {
  const ProductOrderState();

  @override
  List<Object> get props => [];
}

final class ProductOrderInitial extends ProductOrderState {}

final class ProductOrderLoaded extends ProductOrderState {
  final List<ProductOrderEntity> productOrders;

  const ProductOrderLoaded({required this.productOrders});
}

final class ProductOrderError extends ProductOrderState {}

final class ProductOrderLoading extends ProductOrderState {}
