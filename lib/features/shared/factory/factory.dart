import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/profile/edit_profile/model/updated_user.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';

// TODO: add comments
class AbstractFactory {
  AbstractFactory._();

  static BaseUser createUser({
    required UserType userType,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    switch (userType) {
      case UserType.curentUser:
        return User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
        );
      case UserType.updatedUser:
        return UpdatedUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
        );
    }
  }
}

enum UserType {
  curentUser,
  updatedUser,
}
