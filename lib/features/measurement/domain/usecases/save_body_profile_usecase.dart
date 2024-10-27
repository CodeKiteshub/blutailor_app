import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/measurement/domain/repo/measurement_repo.dart';
import 'package:fpdart/fpdart.dart';

class SaveBodyProfileUsecase implements UseCase<String, BodyProfileParams> {
  final MeasurementRepo repository;

  SaveBodyProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call({BodyProfileParams? params}) async {
    return await repository.saveBodyProfile(
      age: params!.age,
      bodyPosture: params.bodyPosture,
      bodyShape: params.bodyShape,
      countryCode: params.countryCode,
      email: params.email,
      firstName: params.firstName,
      fitPreference: params.fitPreference,
      height: params.height,
      lastName: params.lastName,
      phone: params.phone,
      shoulderType: params.shoulderType,
      weight: params.weight,
      frontPicture: params.frontPicture,
      backPicture: params.backPicture,
      sidePicture: params.sidePicture
    );
  }
}

class BodyProfileParams {
  final String age;
  final String? bodyPosture;
  final String? bodyShape;
  final String countryCode;
  final String email;
  final String firstName;
  final String fitPreference;
  final String height;
  final String lastName;
  final String phone;
  final String? shoulderType;
  final String weight;
  final String? frontPicture;
  final String? backPicture;
  final String? sidePicture;

  BodyProfileParams({
    required this.age,
    this.bodyPosture,
    this.bodyShape,
    required this.countryCode,
    required this.email,
    required this.firstName,
    required this.fitPreference,
    required this.height,
    required this.lastName,
    required this.phone,
    this.shoulderType,
    required this.weight,
    this.backPicture,
    this.frontPicture,
    this.sidePicture
  });
}
