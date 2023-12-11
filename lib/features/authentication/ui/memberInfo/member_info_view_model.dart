import 'package:journal_app/features/journal/extensions/string_extensions.dart';
import 'package:journal_app/features/shared/services/http_service.dart';
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

  Future<void> initialize() async {
    setBusy(true);

    // create temp user for registration
    await userService.createTempUser();

    // if value is null assign empty string
    firstName = userService.tempUser?.firstName ?? '';
    lastName = userService.tempUser?.lastName ?? '';
    phoneNumber = userService.tempUser?.phoneNumber ?? '';
    email = userService.tempUser?.email ?? '';

    setBusy(false);
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
    // ensure email is always lower case to match backend
    email = text.trim().toLowerCase();
    userService.tempUser?.email = email;
    notifyListeners();
  }

  void setObscure(bool isObscured) {
    obscurePassword = isObscured;
    notifyListeners();
  }

  void setPhoneNumber(String text) {
    // E164Standard pohne number format expected by the backend
    String phoneNumberWithCountryCode = _formatPhoneNumberE164Standard(text);
    phoneNumber = phoneNumberWithCountryCode;
    userService.tempUser?.phoneNumber = phoneNumberWithCountryCode;
    notifyListeners();
  }

  Future<bool> checkAvailableEmail({required String email}) async {
    setBusy(true);
    final Response response = await authService.checkAvailableEmail(email: email);
    setBusy(false);

    if (response.statusCode == 200) {
      return true;
    } else {
      toastService.showSnackBar(
        message: getErrorMsg(response.body),
      );
      return false;
    }
  }
}

/// returns a string representation of a phone number in e164 format.
String _formatPhoneNumberE164Standard(String phoneNumber) {
  return '+1${(phoneNumber.replaceAll('-', '').replaceAll(' ', '')).replaceAll('(', '').replaceAll(')', '')}';
}
