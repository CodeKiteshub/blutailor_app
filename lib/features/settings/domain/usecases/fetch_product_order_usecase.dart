import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/settings/domain/entities/product_order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchProductOrderUsecase implements UseCase<List<ProductOrderEntity>, String>{
  final SettingsRepo settingsRepo;

  FetchProductOrderUsecase({required this.settingsRepo});

  @override
  Future<Either<Failure, List<ProductOrderEntity>>> call({String? params}) async {
    return await settingsRepo.fetchAppOrder();
  }
}