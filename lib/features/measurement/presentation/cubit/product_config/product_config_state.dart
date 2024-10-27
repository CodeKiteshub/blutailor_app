part of 'product_config_cubit.dart';

@immutable
sealed class ProductConfigState {}

final class ProductConfigInitial extends ProductConfigState {}

final class ProductConfigLoading extends ProductConfigState {}

final class ProductConfigLoaded extends ProductConfigState {
  final List<OptionEntity> productConfig;
  final String subCat;
  ProductConfigLoaded({required this.productConfig, required this.subCat});
}

final class ProductConfigError extends ProductConfigState {
  final String message;
  ProductConfigError({required this.message});
}
