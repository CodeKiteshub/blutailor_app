// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/common/entities/product_config_entity.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchProductConfigUseCase
    implements UseCase<List<ProductConfigEntity>, String> {
  final MeasurementRepo measurementRepo;
  FetchProductConfigUseCase({
    required this.measurementRepo,
  });

  @override
  Future<Either<Failure, List<ProductConfigEntity>>> call({String? params}) async{
    return await measurementRepo.fetchProductConfig(catId: params!);
  }
}
