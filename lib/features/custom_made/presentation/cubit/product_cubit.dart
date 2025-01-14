import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';
import 'package:bluetailor_app/features/custom_made/domain/usecase/add_item_to_cart_usecase.dart';
import 'package:bluetailor_app/features/custom_made/domain/usecase/fetch_product_usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductUsecase _fetchProductUsecase;
  final AddProductItemToCartUsecase _addProductItemToCartUsecase;
  ProductCubit({required FetchProductUsecase fetchProductUsecase,
    required AddProductItemToCartUsecase addProductItemToCartUsecase})
      : _fetchProductUsecase = fetchProductUsecase,
        _addProductItemToCartUsecase = addProductItemToCartUsecase,
        super(ProductInitial());

  List<ProductEntities> products = [];

  fetchProducts({required int page, required String catId, String searchTerm = ""}) async {
    if (page == 1) {
      emit(ProductLoading());
    }
    final result = await _fetchProductUsecase.call(
        params: FetchProductParams(
            page: page,
            catId: catId,
            occassionId: "5fc2677bfa7ff20df01ab8ce",
            searchTerm: searchTerm));

    result.fold((l) {
      emit(ProductError());
    }, (r) {
      products.addAll(r);
      emit(ProductLoaded(products: products));
    });
  }



  addProductToCart({required String catId,
    required dynamic deliveryDays,
    required dynamic disc,
    required dynamic discPrice,
    required dynamic isPer,
    required dynamic price,
    required String name,
    required String itemId,
    required List<String> images,
    required String producttypeId,
    required List<SelectedStylingEntity> styles}) async {
      emit(ProductLoading());
    final result = await _addProductItemToCartUsecase.call(
        params: AddItemToCartParams(
            catId: catId,
            deliveryDays: deliveryDays,
            disc: disc,
            discPrice: discPrice,
            isPer: isPer,
            price: price,
            name: name,
            itemId: itemId,
            images: images,
            producttypeId: producttypeId,
            styles: styles
        ));
    result.fold((l) {
      emit(ProductError());
    }, (r) {
      emit(ProductAddedToCart());
    });
  }
}
