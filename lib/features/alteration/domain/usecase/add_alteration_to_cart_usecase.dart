// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/repo/alteration_repo.dart';

class AddAlterationToCartUsecase
    implements UseCase<String, AddAlterationToCartParam> {
  final AlterationRepo alterationRepo;

  AddAlterationToCartUsecase({required this.alterationRepo});
  @override
  Future<Either<Failure, String>> call(
      {AddAlterationToCartParam? params}) async {
    return await alterationRepo.addAlterationToCart(
        catId: params!.catId,
        catName: params.catName,
        alterationId: params.alterationId,
        alterations: params.alterations);
  }
}

class AddAlterationToCartParam {
  String catId;
  String catName;
  String alterationId;
  List<AlterationEntity> alterations;
  AddAlterationToCartParam({
    required this.catId,
    required this.catName,
    required this.alterationId,
    required this.alterations,
  });
}
