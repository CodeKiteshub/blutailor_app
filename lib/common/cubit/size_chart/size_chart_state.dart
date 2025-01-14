part of 'size_chart_cubit.dart';

@immutable
sealed class SizeChartState {}

final class SizeChartInitial extends SizeChartState {}

final class SizeChartLoading extends SizeChartState {}

final class SizeChartLoaded extends SizeChartState {
  final List<SizeChartEntity> sizeChart;

  SizeChartLoaded({required this.sizeChart});
}

final class SizeChartError extends SizeChartState {
  final String message;

  SizeChartError({required this.message});
}
