part of 'user_attribute_cubit.dart';

@immutable
sealed class UserAttributeState {}

final class UserAttributeInitial extends UserAttributeState {}

final class UserAttributeLoading extends UserAttributeState {}

final class UserAttributeLoaded extends UserAttributeState {
  final List<UserAttributeEntity> userAttributes;
  UserAttributeLoaded({required this.userAttributes});
}

final class UserAttributeError extends UserAttributeState {
  final String message;
  UserAttributeError({required this.message});
}
