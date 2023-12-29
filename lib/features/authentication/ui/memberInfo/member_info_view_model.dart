import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/utilities/string_extensions.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class MemberInfoViewModel extends ReactiveViewModel {
  String? _firstName;

  String? _lastName;

  String? _email;

  String? _phoneNumber;

  bool _obscurePassword = true;

  ImageProvider? _mindfulImage;

  // getter computer variables

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  bool get obscurePassword => _obscurePassword;

  ImageProvider? get mindfulImage => _mindfulImage;

  /// Check required fields are filled in
  bool get ready {
    return _firstName != null &&
        _firstName!.isNotEmpty &&
        _lastName != null &&
        _lastName!.isNotEmpty &&
        _email != null &&
        _email!.isNotEmpty &&
        _phoneNumber != null &&
        _phoneNumber!.isNotEmpty;
  }

  // required override to listen to changes in service state
  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
        imageService,
      ];

  Future<void> initialize() async {
    _mindfulImage = imageService.getRandomMindfulImage();

    setBusy(true);

    // create temp user for registration
    await userService.createTempUser();

    // if value is null assign empty string
    _firstName = userService.tempUser?.firstName ?? '';
    _lastName = userService.tempUser?.lastName ?? '';
    _phoneNumber = userService.tempUser?.phoneNumber ?? '';
    _email = userService.tempUser?.email ?? '';

    setBusy(false);
  }

  void setFirstName(String text) {
    _firstName = text.toLowerCase().capitalize().trim();

    debugPrint("member info first name: $_firstName");

    userService.setTempUserFirstName(_firstName!);

    notifyListeners();
  }

  void setLastName(String text) {
    _lastName = text.toLowerCase().capitalize().trim();

    debugPrint("member info last name: $_lastName");

    userService.setTempUserLastName(_lastName!);

    notifyListeners();
  }

  void setEmail(String text) {
    // ensure email is always lower case to match backend
    _email = text.trim().toLowerCase();

    userService.setTempUserEmail(_email!);

    notifyListeners();
  }

  void setObscure(bool isObscured) {
    _obscurePassword = isObscured;
    notifyListeners();
  }

  void setPhoneNumber(String text) {
    // E164Standard pohne number format expected by the backend API.
    String phoneNumberWithCountryCode = _formatPhoneNumberE164Standard(text);
    _phoneNumber = phoneNumberWithCountryCode;

    userService.setTempUserPhoneNumber(phoneNumberWithCountryCode);

    notifyListeners();
  }

  /// API call to backend database, checking specified email availability.
  Future<bool> checkAvailableEmail({required String email}) async {
    setBusy(true);
    final Response response = await authService.checkAvailableEmail(email: email);
    setBusy(false);

    // indicate if response status was statusOK
    final bool statusOk = ResponseHandler.checkStatusCode(response);

    if (!statusOk) {
      toastService.showSnackBar(
        message: ResponseHandler.getErrorMsg(response.body),
        textColor: Colors.red,
      );

      return statusOk;
    }

    return statusOk;
  }
}

/// returns a string representation of a phone number in e164 format required by the backend API.
String _formatPhoneNumberE164Standard(String phoneNumber) {
  return '+1${(phoneNumber.replaceAll('-', '').replaceAll(' ', '')).replaceAll('(', '').replaceAll(')', '')}';
}
