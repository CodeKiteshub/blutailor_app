import 'package:bluetailor_app/core/errors/failure.dart';
import 'package:bluetailor_app/core/usecase/usecase.dart';
import 'package:bluetailor_app/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:bluetailor_app/features/settings/domain/repo/settings_repo.dart';
import 'package:fpdart/fpdart.dart';

class EditProfileUsecase implements UseCase<String, UserParams> {
  final SettingsRepo settingsRepo;

  EditProfileUsecase({required this.settingsRepo});
  @override
  Future<Either<Failure, String>> call({UserParams? params}) async {
    return await settingsRepo.editProfile(
        firstName: params!.firstName!,
        lastName: params.lastName!,
        email: params.email!,
        phone: params.phoneNumber,
        profilePic: params.profilePic ?? "");
  }
}
