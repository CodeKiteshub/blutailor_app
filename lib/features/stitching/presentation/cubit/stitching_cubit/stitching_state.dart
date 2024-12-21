part of 'stitching_cubit.dart';

@immutable
sealed class StitchingState {}

final class StitchingInitial extends StitchingState {}

final class StitchingLoading extends StitchingState {}

final class StitchingSaved extends StitchingState {}

final class StitchingSignedUrlError extends StitchingState {}

final class StitchingError extends StitchingState {
  final String message;
  StitchingError({required this.message});
}