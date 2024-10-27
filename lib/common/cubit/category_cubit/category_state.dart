part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<ProductCatEntity> categories;
  CategoryLoaded({required this.categories});
}

final class CategoryError extends CategoryState {
  final String message;
  CategoryError({required this.message});
}
