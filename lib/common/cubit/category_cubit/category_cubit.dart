
import 'package:bluetailor_app/common/entities/product_cat_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_cat_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FetchCatUsecase _fetchCatUsecase;
  CategoryCubit({required FetchCatUsecase fetchCatUsecase}) : 
  _fetchCatUsecase = fetchCatUsecase,
  super(CategoryInitial());

  fetchGarmentUseCase() async {
    final res = await _fetchCatUsecase.call();

    res.fold((l) => emit(CategoryError(message: l.message)), 
    (r) => emit(CategoryLoaded(categories: r)));
  }
}
