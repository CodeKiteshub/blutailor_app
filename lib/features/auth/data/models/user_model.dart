
import 'package:bluetailor_app/common/entities/user.dart';

class UserModel extends User {

  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phone,
    super.profilePic
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['_id'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phone: data['phone'],
      profilePic: data["images"]["profile"] ?? ""
    );
  }
}
