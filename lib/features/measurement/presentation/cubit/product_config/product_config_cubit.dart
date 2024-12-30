import 'package:bluetailor_app/features/measurement/domain/entities/measurement_answer_entity.dart';
import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/usecases/fetch_product_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_config_state.dart';

class ProductConfigCubit extends Cubit<ProductConfigState> {
  final FetchProductConfigUseCase _productConfigUsecase;
  ProductConfigCubit(
      {required FetchProductConfigUseCase fetchProductConfigUsecase})
      : _productConfigUsecase = fetchProductConfigUsecase,
        super(ProductConfigInitial());

  List<MeasurementAnswerEntity> answers = [];

  fetchProductConfig({required String catId}) async {
    emit(ProductConfigLoading());
    final response = await _productConfigUsecase.call(params: catId);
    response.fold(
      (l) => emit(ProductConfigError(message: l.message)),
      (r) {
        if (catId == "5da7220571762c2a58b27a65") {
          r
              .firstWhere((e) => e.subCat == "full_shirt")
              .options
              .forEach((element) {
            answers.add(MeasurementAnswerEntity(
                label: element.label,
                inchController: TextEditingController(),
                cmController: TextEditingController(),
                selectedDropDownValue: "0"));
          });
          emit(ProductConfigLoaded(
              productConfig:
                  r.firstWhere((e) => e.subCat == "full_shirt").options,
              subCat: r.firstWhere((e) => e.subCat == "full_shirt").subCat));
        } else {
          r.firstOrNull?.options.forEach((element) {
            answers.add(MeasurementAnswerEntity(
                label: element.label,
                inchController: TextEditingController(),
                cmController: TextEditingController(),
                selectedDropDownValue: "0"));
          });
          emit(ProductConfigLoaded(
              productConfig: r.firstOrNull?.options ?? [],
              subCat: r.firstOrNull?.subCat ?? ""));
        }
      },
    );
  }


  @override
  Future<void> close() {
    // Clean up answer controllers
    for (var answer in answers) {
      answer.inchController?.dispose();
      answer.cmController?.dispose();
    }
    answers.clear();
    return super.close();
  }
}
