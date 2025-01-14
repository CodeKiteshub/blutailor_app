// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';
import 'package:bluetailor_app/features/custom_made/domain/repo/custom_made_repo.dart';
import 'package:fpdart/fpdart.dart';

import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';

class FetchProductUsecase implements UseCase<List<ProductEntities>, FetchProductParams> {
  final CustomMadeRepo customMadeRepo;

  FetchProductUsecase({required this.customMadeRepo});
  @override
  Future<Either<Failure, List<ProductEntities>>> call({FetchProductParams? params}) async {
    return await customMadeRepo.fetchProducts(
        occassionId: params!.occassionId,
        catId: params.catId,
        searchTerm: params.searchTerm,
        page: params.page);
  }
}

class FetchProductParams {
  String occassionId;
  String catId;
  String searchTerm;
  int page;
  FetchProductParams({
    required this.occassionId,
    required this.catId,
    required this.searchTerm,
    required this.page,
  });
}
