part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductEntities> products;

  const ProductLoaded({required this.products});
}

final class ProductError extends ProductState {}

final class ProductAddedToCart extends ProductState {}
