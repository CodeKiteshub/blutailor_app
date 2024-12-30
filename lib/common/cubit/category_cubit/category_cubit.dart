import 'package:bluetailor_app/common/entities/product_cat_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_cat_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FetchCatUsecase _fetchCatUsecase;
  CategoryCubit({required FetchCatUsecase fetchCatUsecase})
      : _fetchCatUsecase = fetchCatUsecase,
        super(CategoryInitial());

  fetchGarmentUseCase(bool isStitching, bool isAlteration) async {
    final res = await _fetchCatUsecase.call();

    res.fold((l) => emit(CategoryError(message: l.message)), (r) {
      if (isStitching) {
        r.removeWhere((e) =>
            e.id == "5e6c843c3a2df13444183298" || e.id == "636f3012feea0816508c5c45" ||
            e.id == "5e6c845a3a2df13444183299");
        emit(CategoryLoaded(categories: r));
      } else if (isAlteration) {
        r.removeWhere((e) =>
            e.id == "5e6c843c3a2df13444183298" ||
            e.id == "5e6c845a3a2df13444183299");
        emit(CategoryLoaded(categories: r));
      } else {
        emit(CategoryLoaded(categories: r));
      }
    });
  }
}
