part of 'alteration_config_cubit.dart';

@immutable
sealed class AlterationConfigState {}

final class AlterationConfigInitial extends AlterationConfigState {}

final class AlterationConfigLoading extends AlterationConfigState {}

final class AlterationConfigLoaded extends AlterationConfigState {
  final List<OptionEntity> config;

  AlterationConfigLoaded({required this.config});
}

final class AlterationConfigError extends AlterationConfigState {}
