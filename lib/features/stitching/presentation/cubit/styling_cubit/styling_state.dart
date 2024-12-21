part of 'styling_cubit.dart';

@immutable
sealed class StylingState {}

final class StylingInitial extends StylingState {}

final class StylingUpdated extends StylingState {}

