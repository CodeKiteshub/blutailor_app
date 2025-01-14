import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/repo/stitching_repo.dart';
import 'package:bluetailor_app/features/stitching/domain/usecase/save_stitching_usecase.dart';
import 'package:fpdart/fpdart.dart';

class AddItemToCartUsecase implements UseCase<String, StitchingDataModel>{
  final StitchingRepo stitchingRepo;

  AddItemToCartUsecase({required this.stitchingRepo});
  @override
  Future<Either<Failure, String>> call({StitchingDataModel? params}) async {
    return await stitchingRepo.addItemToStitchingCart(
        catId: params!.catId,
        stitchingId: params.stitchingId,
        fabricName: params.fabricName,
        stylingNote: params.stylingNote,
        price: params.price,
        styling: params.styling
    );
  }
}