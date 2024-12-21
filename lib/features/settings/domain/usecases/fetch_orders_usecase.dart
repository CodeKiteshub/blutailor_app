import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/settings/domain/entities/order_entity.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchOrdersUsecase implements UseCase<List<OrderEntity>, void> {
  final SettingsRepo settingsRepo;

  FetchOrdersUsecase({required this.settingsRepo});

  @override
  Future<Either<Failure, List<OrderEntity>>> call({void params}) async {
    return await settingsRepo.orderHistory();
  }
}
