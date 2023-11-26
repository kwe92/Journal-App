import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class MemberInfoViewModel extends BaseViewModel {
  String? firstName;

  String? lastName;

  String? email;

  String? phoneNumber;

  void setFirstName(String text) {
    firstName = text;
    userService.tempUser?.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String text) {
    lastName = text;
    userService.tempUser?.lastName = lastName;
    notifyListeners();
  }

  void setEmail(String text) {
    email = text.trim();
    userService.tempUser?.email = email;
    notifyListeners();
  }

  void setPhoneNumber(String text) {
    String phoneNumberWithCountryCode = '+1${(text.replaceAll('-', '').replaceAll(' ', '')).replaceAll('(', '').replaceAll(')', '')}';
    phoneNumber = phoneNumberWithCountryCode;
    userService.tempUser?.phoneNumber = phoneNumberWithCountryCode;
    notifyListeners();
  }
}
