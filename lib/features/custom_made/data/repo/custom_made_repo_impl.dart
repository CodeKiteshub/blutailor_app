import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/custom_made/data/data_source/custom_made_data_source.dart';
import 'package:bluetailor_app/features/custom_made/data/model/product_model.dart';
import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';
import 'package:bluetailor_app/features/custom_made/domain/repo/custom_made_repo.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:fpdart/fpdart.dart';

class CustomMadeRepoImpl implements CustomMadeRepo {
  final CustomMadeDataSource customMadeDataSource;

  CustomMadeRepoImpl({required this.customMadeDataSource});
  @override
  Future<Either<Failure, List<ProductEntities>>> fetchProducts(
      {required String occassionId,
      required String catId,
      required String searchTerm,
      required int page}) async {
    try {
      final result = await customMadeDataSource.fetchProducts(
          occassionId: occassionId,
          catId: catId,
          searchTerm: searchTerm,
          page: page);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(List<ProductEntities>.from(result.data!["productsFilter"]
              ["products"]
          .map((e) => ProductModel.fromMap(e))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addItemToCart(
      {required String catId,
      required deliveryDays,
      required disc,
      required discPrice,
      required isPer,
      required price,
      required String name,
      required String itemId,
      required List<String> images,
      required String producttypeId,
      required List<SelectedStylingEntity> styles}) async {
    try {
      final result = await customMadeDataSource.addItemToCart(
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
          qty: 1,
          styles: styles);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!.toString());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
