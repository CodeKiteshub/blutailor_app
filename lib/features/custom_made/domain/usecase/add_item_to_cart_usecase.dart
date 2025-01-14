// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/custom_made/domain/repo/custom_made_repo.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';

class AddProductItemToCartUsecase implements UseCase<String, AddItemToCartParams> {
  final CustomMadeRepo customMadeRepo;

  AddProductItemToCartUsecase({required this.customMadeRepo});
  @override
  Future<Either<Failure, String>> call({AddItemToCartParams? params}) {
    return customMadeRepo.addItemToCart(
      catId: params!.catId,
      deliveryDays: params.deliveryDays,
      disc: params.disc,
      discPrice: params.discPrice,
      isPer: params.isPer,
      price: params.price,
      name: params.name,
      itemId: params.itemId,
      images: params.images,
      producttypeId: params.producttypeId,
      
      styles: params.styles
    );
  }
}

class AddItemToCartParams {
  String catId;
  int deliveryDays;
  dynamic disc;
  dynamic discPrice;
  bool isPer;
  dynamic price;
  String name;
  String itemId;
  List<String> images;
  String producttypeId;
  List<SelectedStylingEntity> styles;
  AddItemToCartParams({
    required this.catId,
    required this.deliveryDays,
    required this.disc,
    required this.discPrice,
    required this.isPer,
    required this.price,
    required this.name,
    required this.itemId,
    required this.images,
    required this.producttypeId,
    required this.styles,
  });
}
