import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CustomMadeRepo {
  Future<Either<Failure, List<ProductEntities>>> fetchProducts({
    required String occassionId,
    required String catId,
    required String searchTerm,
    required int page
  });
  Future<Either<Failure, String>> addItemToCart(
      {required String catId,
      required dynamic deliveryDays,
      required dynamic disc,
      required dynamic discPrice,
      required dynamic isPer,
      required dynamic price,
      required String name,
      required String itemId,
      required List<String> images,
      required String producttypeId,
      required List<SelectedStylingEntity> styles
  });
}