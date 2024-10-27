part of 'user_measurement_cubit.dart';

@immutable
sealed class UserMeasurementState {}

final class UserMeasurementInitial extends UserMeasurementState {}

final class UserMeasurementLoading extends UserMeasurementState {}

final class UserMeasurementError extends UserMeasurementState {
  final String message;

  UserMeasurementError({required this.message});
}

final class UserMeasurementLoaded extends UserMeasurementState {
  final List<OptionEntity> userAttributes;

  UserMeasurementLoaded({required this.userAttributes});
}
