import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/journal/extensions/string_extensions.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

class MemberInfoViewModel extends BaseViewModel {
  String? firstName;

  String? lastName;

  String? email;

  String? phoneNumber;

  bool obscurePassword = true;

  /// Check that all required fields are filled in
  bool get ready {
    return firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        phoneNumber != null &&
        phoneNumber!.isNotEmpty;
  }

  void setFirstName(String text) {
    firstName = text != '' ? text.capitalize().trim() : '';
    userService.tempUser?.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String text) {
    lastName = text != '' ? text.capitalize().trim() : '';
    userService.tempUser?.lastName = lastName;
    notifyListeners();
  }

  void setEmail(String text) {
    email = text.trim().toLowerCase();
    userService.tempUser?.email = email;
    notifyListeners();
  }

  void setObscure(bool isObscured) {
    obscurePassword = isObscured;

    notifyListeners();
  }

  void setPhoneNumber(String text) {
    String phoneNumberWithCountryCode = _formatPhoneNumberE164Standard(text);
    phoneNumber = phoneNumberWithCountryCode;
    userService.tempUser?.phoneNumber = phoneNumberWithCountryCode;
    notifyListeners();
  }

  Future<Response> signupWithEmail({required User user}) async {
    setBusy(true);
    Response response = await authService.register(user: user);
    setBusy(false);
    return response;
  }
}

/// _formatPhoneNumberE164Standard: returns a string representation of a phone number in e164 format.
String _formatPhoneNumberE164Standard(String phoneNumber) {
  return '+1${(phoneNumber.replaceAll('-', '').replaceAll(' ', '')).replaceAll('(', '').replaceAll(')', '')}';
}
