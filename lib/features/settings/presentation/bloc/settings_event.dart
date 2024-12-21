part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class EditProfileEvent extends SettingsEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String profilePicPath;

  EditProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profilePicPath
  });
}

class FetchStoreOrderEvent extends SettingsEvent {}

class FetchProductOrderEvent extends SettingsEvent {}

class FetchOrderHistoryEvent extends SettingsEvent {}