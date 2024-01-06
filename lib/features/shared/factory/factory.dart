import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/profile/edit_profile/model/updated_user.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';

/// Responsible for the creation (instantiation) of all consumed concrete class implementations for both high level and low level modules
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

  static BaseUser createUserFromJson({
    required UserType userType,
    required Map<String, dynamic> json,
  }) {
    switch (userType) {
      case UserType.curentUser:
        return User.fromJSON(json);
      case UserType.updatedUser:
        return UpdatedUser.fromJSON(json);
    }
  }
}

enum UserType {
  curentUser,
  updatedUser,
}



// Factory Method Pattern (Creational Design Pattern) | static Class That Creates Objects

//   - also referred to as the Virtual Constructor Pattern
//   - one of the most widely used creational design patterns
//   - used to create objects via a static Factory class
//   - the Factory class implements static methods containing creation logic, where objects are created at compile time
//   - Factory class methods create and return objects adhering to abstraction contracts (i.e. the return type of a Factory static method is an interface or abstract class)
//   - Factory method implementations conceal creation logic away from clients
//   - adds flexibility to object creation architecture without adding too much complexity
//   - contains concrete dependancies adhering to abstract contracts
