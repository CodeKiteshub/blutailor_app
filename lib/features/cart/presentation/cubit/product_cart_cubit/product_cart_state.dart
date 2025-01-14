part of 'product_cart_cubit.dart';

sealed class ProductCartState extends Equatable {
  const ProductCartState();

  @override
  List<Object> get props => [];
}

final class ProductCartInitial extends ProductCartState {}

final class ProductCartLoading extends ProductCartState {}

final class ProductCartLoaded extends ProductCartState {
  final ProductCartEntity cart;
  const ProductCartLoaded({required this.cart});
}

final class ProductCartError extends ProductCartState {}
