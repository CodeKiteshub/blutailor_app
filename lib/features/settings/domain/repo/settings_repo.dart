import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/settings/domain/entities/product_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/entities/store_order_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SettingsRepo {
  Future<Either<Failure, String>> editProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String profilePic});
  Future<Either<Failure, List<StoreOrderEntity>>> storeOrder();
  Future<Either<Failure, List<ProductOrderEntity>>> fetchAppOrder();
  Future<Either<Failure, String>> fetchProfileSignedUrl({required String ext});
}
