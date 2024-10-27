import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/settings/domain/entities/store_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchStoreOrderUsecase
    implements UseCase<List<StoreOrderEntity>, String> {
  final SettingsRepo settingsRepo;

  FetchStoreOrderUsecase({required this.settingsRepo});
  @override
  Future<Either<Failure, List<StoreOrderEntity>>> call({String? params}) async {
    return await settingsRepo.storeOrder();
  }
}
