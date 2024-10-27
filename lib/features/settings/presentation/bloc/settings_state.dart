part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class EditProfileDone extends SettingsState {
  final String message;

  EditProfileDone({required this.message});
}


final class SettingsError extends SettingsState {
  final String message;

  SettingsError({required this.message});
}

final class StoreOrderLoaded extends SettingsState {
  final List<StoreOrderEntity> storeOrders;

  StoreOrderLoaded({required this.storeOrders});
}

final class ProductOrderLoaded extends SettingsState {
  final List<ProductOrderEntity> productOrders;

  ProductOrderLoaded({required this.productOrders});
}