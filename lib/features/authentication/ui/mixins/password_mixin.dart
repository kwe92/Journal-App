import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

mixin PasswordMixin on ReactiveViewModel {
  String? email;
  String? password;
  String? confirmPassword;
  bool obscurePassword = true;
  bool showRequirements = false;

  @override
  List<ListenableServiceMixin> get listenableServices => [userService];

  void setEmail(String text) {
    email = text.trim();
    notifyListeners();
  }

  void setPassword(String text) {
    password = text.trim();
    userService.setTempUserPassword(password!);
    notifyListeners();
  }

  void setConfirmPassword(String text) {
    confirmPassword = text;
    notifyListeners();
  }

  void setObscure(bool isObscured) {
    obscurePassword = isObscured;
    notifyListeners();
  }

  void setShowRequirements(bool showReq) {
    showRequirements = showReq;
    notifyListeners();
  }

  bool passwordRequirementsSatisfied() {
    if (!stringService.containsUppercase(password)) return false;

    if (!stringService.containsLowercase(password)) return false;

    if (!stringService.containsSpecialCharacter(password)) return false;

    if (!stringService.containsNumber(password)) return false;

    if (!stringService.contains8Characters(password)) return false;

    return true;
  }
}

class ImplementExample {
  String requiredMethodImplementation(String mustBeImplemented) {
    return "";
  }
}

// Mixin 

//   - reuse code between multiple classes
//   - classes can only extend or inherit from one class
//   - additional classes must be implemented 
//     `the implementing class must define all accosiated methods via @override annotation`
//   - a kind of multi-inheritance
//   - all implemented methods and defined member variables are inherited (mixed in)


// mixin on

//   - the on keyword of a mixin requires the class using the mixin to
//     inherit/extend the associated super-class defined or the mixin will throw a compile-time error

// with keyword

//   - classes that want to use a mixin must prefix the associated mixin name using with keyword
//     in the class definition
