part of 'save_alteration_cubit.dart';

@immutable
sealed class SaveAlterationState {}

final class SaveAlterationInitial extends SaveAlterationState {}

final class SaveAlterationLoading extends SaveAlterationState {}

final class SavedAlteration extends SaveAlterationState {}

final class SaveAlterationError extends SaveAlterationState {}

