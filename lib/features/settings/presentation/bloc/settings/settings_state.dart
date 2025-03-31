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



final class OrderHistoryLoaded extends SettingsState {
  final List<OrderEntity> orderHistory;

  OrderHistoryLoaded({required this.orderHistory});
}