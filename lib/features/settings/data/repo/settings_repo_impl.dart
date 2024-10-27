import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/features/settings/data/data_source/settings_data_source.dart';
import 'package:bluetailor_app/features/settings/data/model/product_order_model.dart';
import 'package:bluetailor_app/features/settings/data/model/store_order_model.dart';
import 'package:bluetailor_app/features/settings/domain/entities/product_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/entities/store_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:fpdart/fpdart.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsDataSource settingsDataSource;

  SettingsRepoImpl({required this.settingsDataSource});
  @override
  Future<Either<Failure, String>> editProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String profilePic}) async {
    try {
      final result = await settingsDataSource.editProfile(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          profilePic: profilePic);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right('Profile updated successfully');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StoreOrderEntity>>> storeOrder() async {
    try {
      final result = await settingsDataSource.storeOrder();
      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(List<StoreOrderModel>.from(result.data!['getAllStoreOrders']
          .map((order) => StoreOrderModel.fromJson(order))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductOrderEntity>>> fetchAppOrder() async {
    try {
      final result = await settingsDataSource.appOrder();
      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }
      return right(List<ProductOrderModel>.from(result
          .data!['getAllUserProductOrders']
          .map((order) => ProductOrderModel.fromJson(order))));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> fetchProfileSignedUrl(
      {required String ext}) async {
    try {
      final result =
          await settingsDataSource.fetchProfilePictureSignedUrl(ext: ext);

      if (result.hasException) {
        return left(Failure(result.exception.toString()));
      }

      return right(result.data!["getUserProfilePictureImageSignedUrl__app"]
          ["signedUrl"]);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
