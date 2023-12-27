import 'package:journal_app/features/journal/extensions/string_extensions.dart';
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

  String? _mindfulImage;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  bool get obscurePassword => _obscurePassword;

  String? get mindfulImage => _mindfulImage;

  /// Check that all required fields are filled in
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

  @override
  List<ListenableServiceMixin> get listenableServices => [userService];

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
    _firstName = text != '' ? text.toLowerCase().capitalize().trim() : '';

    userService.setTempUserFirstName(_firstName!);

    notifyListeners();
  }

  void setLastName(String text) {
    _lastName = text != '' ? text.toLowerCase().capitalize().trim() : '';

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
    // E164Standard pohne number format expected by the backend
    String phoneNumberWithCountryCode = _formatPhoneNumberE164Standard(text);
    _phoneNumber = phoneNumberWithCountryCode;

    userService.setTempUserPhoneNumber(phoneNumberWithCountryCode);

    notifyListeners();
  }

  /// check backend database to ensure the specified email is available
  Future<bool> checkAvailableEmail({required String email}) async {
    setBusy(true);
    final Response response = await authService.checkAvailableEmail(email: email);
    setBusy(false);

    // indicate if response status was statusOK
    return ResponseHandler.checkStatusCode(response);
  }
}

/// returns a string representation of a phone number in e164 format.
String _formatPhoneNumberE164Standard(String phoneNumber) {
  return '+1${(phoneNumber.replaceAll('-', '').replaceAll(' ', '')).replaceAll('(', '').replaceAll(')', '')}';
}
