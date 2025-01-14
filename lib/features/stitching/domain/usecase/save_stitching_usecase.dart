import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/repo/stitching_repo.dart';
import 'package:fpdart/fpdart.dart';


class SaveStitchingUsecase implements UseCase<String, StitchingDataModel>{
  final StitchingRepo stitchingRepo;
  SaveStitchingUsecase({required this.stitchingRepo});

  @override
  Future<Either<Failure, String>> call({StitchingDataModel? params}) async{
    return await stitchingRepo.saveStitching(
        catId: params!.catId,
        fabricName: params.fabricName,
        fabricImage: params.fabricImage,
        fabricLength: params.fabricLength,
        fabricWidth: params.fabricWidth,
        fabricNote: params.fabricNote,
        stylingNote: params.stylingNote,
        styling: params.styling
    );
  }
}


class StitchingDataModel {
  String stitchingId;
  String catId;
  String fabricName;
  String fabricImage;
  double fabricLength;
  double fabricWidth;
  String fabricNote;
  String stylingNote;
  dynamic price;
  List<SelectedStylingEntity> styling;

  StitchingDataModel(
      {required this.catId,
      this.stitchingId = "",
      required this.fabricName,
      required this.fabricImage,
      required this.fabricLength,
      required this.fabricWidth,
      required this.fabricNote,
      required this.stylingNote,
      required this.price,
      required this.styling});
}