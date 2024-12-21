import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/styling_config_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/repo/stitching_repo.dart';
import 'package:fpdart/fpdart.dart';


class FetchCustomStylingUsecase implements UseCase<List<StylingConfigEntity>, String>{
  final StitchingRepo stitchingRepo;

  FetchCustomStylingUsecase({required this.stitchingRepo});
  @override
  Future<Either<Failure, List<StylingConfigEntity>>> call({String? params}) async {
    return await stitchingRepo.fetchStylingConfig(catId: params!);
  }
}