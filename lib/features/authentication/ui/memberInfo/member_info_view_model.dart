import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
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

    // create temp user for registration
    await runBusyFuture(userService.createTempUser());

    // if value is null assign empty string
    _firstName = userService.tempUser?.firstName ?? '';
    _lastName = userService.tempUser?.lastName ?? '';
    _phoneNumber = userService.tempUser?.phoneNumber ?? '';
    _email = userService.tempUser?.email ?? '';
  }

  void setFirstName(String text) {
    _firstName = text.isNotEmpty ? text.toLowerCase().capitalize().trim() : '';

    debugPrint("member info first name: $_firstName");

    userService.setTempUserFirstName(_firstName!);

    notifyListeners();
  }

  void setLastName(String text) {
    _lastName = text.isNotEmpty ? text.toLowerCase().capitalize().trim() : '';

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
    debugPrint(text);

    // E164Standard phone number format expected by the backend API.
    final String phoneNumberWithCountryCode = stringService.formatPhoneNumberE164Standard(text);
    _phoneNumber = phoneNumberWithCountryCode;

    userService.setTempUserPhoneNumber(phoneNumberWithCountryCode);

    notifyListeners();
  }

  /// API call to backend database, checking specified email availability.
  Future<bool> checkAvailableEmail({required String email}) async {
    final Response response = await runBusyFuture(authService.checkAvailableEmail(email: email));

    // indicate if response status was statusOK
    final bool statusOk = ResponseHandler.checkStatusCode(response);

    if (!statusOk) {
      toastService.showSnackBar(
        message: ResponseHandler.getErrorMsg(response.body),
        textColor: AppColors.errorTextColor,
      );

      return statusOk;
    }

    return statusOk;
  }
}
