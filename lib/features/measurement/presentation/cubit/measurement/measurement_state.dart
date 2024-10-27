part of 'measurement_cubit.dart';

@immutable
sealed class MeasurementState {}

final class MeasurementInitial extends MeasurementState {}

final class MeasurementLoading extends MeasurementState {}

final class MeasurementError extends MeasurementState {
  final String message;

  MeasurementError({required this.message});
}

final class MeasurementSaved extends MeasurementState {
  final String message;

  MeasurementSaved({required this.message});
}
