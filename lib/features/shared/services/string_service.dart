import 'package:email_validator/email_validator.dart';
// import 'package:injectable/injectable.dart';

/// StringValidatorConfiguration: a helper class to specify custom string validation configureation.
/// Used in conjunction with the [StringService] customStringValidator method.
///
/// Example: TextField or TextFormField requiring controller.text not to be empty
/// ```dart
/// const stringService = StringService()
/// stringService.customStringValidator(textValue, configuration: const StringValidatorConfiguration(notEmpty: true))
/// ```
class StringValidatorConfiguration {
  final bool notEmpty;
  final bool includesUppercase;
  final bool includesLowercase;
  final bool includesSpecial;
  final bool includesNumber;
  const StringValidatorConfiguration({
    this.notEmpty = false,
    this.includesUppercase = false,
    this.includesLowercase = false,
    this.includesSpecial = false,
    this.includesNumber = false,
  });
}

/// StringService: provides methods for string vaidation, mainly used to validate TextField's and TextFormField's.
// @injectable
class StringService {
  /// Custom validator that looks for specific features in a string
  /// Specify the things you want (notEmpty, containsUppercase, etc)
  String? Function(String?) customStringValidator(
    String value, {
    String label = 'Value',
    StringValidatorConfiguration configuration = const StringValidatorConfiguration(),
  }) {
    return (value) {
      if (configuration.notEmpty && (value == null || value.trim() == '')) {
        return '$label cannot be empty';
      } else if (configuration.includesUppercase && !containsUppercase(value)) {
        return '$label must contain an uppercase letter';
      } else if (configuration.includesLowercase && !containsLowercase(value)) {
        return '$label must contain a lowercase letter';
      } else if (configuration.includesSpecial && !containsSpecialCharacter(value)) {
        return '$label must contain a special character';
      } else if (configuration.includesNumber && !containsNumber(value)) {
        return '$label must contain a number';
      } else {
        return null;
      }
    };
  }

  String? passwordIsValid(String? password) {
    if (isEmpty(password)) {
      return 'Value cannot be empty';
    } else if (!containsUppercase(password)) {
      return 'Password must contain a capital letter';
    } else if (!containsLowercase(password)) {
      return 'Password must contain a lowercase letter';
    } else if (!containsNumber(password)) {
      return 'Password must contain a number';
    } else if (!containsSpecialCharacter(password)) {
      return 'Password must contain a special character';
    } else if (!contains8Characters(password)) {
      return 'Password must contain at least 6 characters';
    } else {
      return null;
    }
  }

  bool isEmpty(value) {
    return (value == null || value.trim() == '');
  }

  bool containsUppercase(String? value) {
    return RegExp(r'(?=.*[A-Z])').hasMatch(value ?? '');
  }

  bool containsLowercase(String? value) {
    return RegExp(r'(?=.*[a-z])').hasMatch(value ?? '');
  }

  bool containsNumber(String? value) {
    return RegExp(r'(?=.*?[0-9])').hasMatch(value ?? '');
  }

  bool containsSpecialCharacter(String? value) {
    return RegExp('[^a-zA-Z0-9d]').hasMatch(value ?? '');
  }

  bool contains8Characters(String? value) {
    return (value ?? '').length >= 8;
  }

  //EMAIL VALIDATION
  String? emailIsValid(String? value) {
    return value != null
        ? !EmailValidator.validate(value.trim())
            ? 'Email format is invalid'
            : null
        : 'Email is empty';
  }

  // TODO: Review

  /// Verify that the password does not contain the username or any
  /// 3+ length strings from the username
  bool noOverlaps({required String password, required String username}) {
    bool passed = true;
    List<String> nameSegments = [];

    for (int x = 0; x < username.length - 2; x++) {
      String segment = username.substring(x, x + 3);
      nameSegments.add(segment.toLowerCase());
    }

    for (var segment in nameSegments) {
      if (password.toLowerCase().contains(segment)) {
        passed = false;
      }
    }

    return passed;
  }
}
