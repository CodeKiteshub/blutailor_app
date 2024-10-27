import 'package:bluetailor_app/features/measurement/domain/entities/size_chart_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_size_chart_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'size_chart_state.dart';

class SizeChartCubit extends Cubit<SizeChartState> {
  final FetchSizeChartUsecase _fetchSizeChartUsecase;
  SizeChartCubit({required FetchSizeChartUsecase fetchSizeChartUsecase})
      : _fetchSizeChartUsecase = fetchSizeChartUsecase,
        super(SizeChartInitial());

  void fetchSizeChart({required String catId}) async {
    emit(SizeChartLoading());
    final result = await _fetchSizeChartUsecase.call(params: catId);
    result.fold((failure) => emit(SizeChartError(message: failure.message)),
        (sizeChart) {
          final sizes = sizeChart.map(
            (e) => e.size,
          ).toSet();
          sizeChart.retainWhere((element) => sizes.remove(element.size));
      sizeChart.sort((a, b) {
        return int.parse(a.size).compareTo(int.parse(b.size));
      });
      emit(SizeChartLoaded(sizeChart: sizeChart.toSet().toList()));
    });
  }
}
