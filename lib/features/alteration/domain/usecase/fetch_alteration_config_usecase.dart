import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/repo/alteration_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchAlterationConfigUsecase implements UseCase<List<ProductConfigEntity>, String> {
  final AlterationRepo alterationRepo;

  FetchAlterationConfigUsecase({required this.alterationRepo});
  @override
  Future<Either<Failure, List<ProductConfigEntity>>> call({String? params}) async {
    return await alterationRepo.fetchAlterationConfig(catId: params!);
  }
}