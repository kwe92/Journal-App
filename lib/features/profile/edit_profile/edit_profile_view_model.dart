import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/factory/factory.dart';
import 'package:journal_app/features/shared/utilities/string_extensions.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends ReactiveViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  // Mutable Variables

  bool _isReadOnly = true;

  String? _updatedFirstName;

  String? _updatedLastName;

  String? _updatedEmail;

  String? _updatedPhoneNumber;

  ImageProvider? _mindfulImage;

  // Computed User Variables

  BaseUser get _currentUser => userService.currentUser!;

  String get userFirstName => _currentUser.firstName!;

  String get userLastName => _currentUser.lastName!;

  String get userEmail => _currentUser.email!;

  String get userPhoneNumber => stringService.formatPhoneNumberNANP(_currentUser.phoneNumber!.substring(2));

  // Computed Update Variables

  String? get updatedFirstName => _updatedFirstName;

  String? get updatedLastName => _updatedLastName;

  String? get updatedEmail => _updatedEmail;

  String? get updatedPhoneNumber => _updatedPhoneNumber;

  bool get isReadOnly => _isReadOnly;

  // Other Computed Variables

  ImageProvider? get mindfulImage => _mindfulImage;

  bool get ready =>
      _updatedFirstName != null &&
      _updatedFirstName!.isNotEmpty &&
      _updatedLastName != null &&
      _updatedLastName!.isNotEmpty &&
      _updatedEmail != null &&
      _updatedEmail!.isNotEmpty;

  bool get isIdenticalInfo =>
      userFirstName == updatedFirstName &&
      userLastName == updatedLastName &&
      userEmail == updatedEmail &&
      stringService.formatPhoneNumberE164Standard(userPhoneNumber) == updatedPhoneNumber;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
        imageService,
      ];

  void initialize() {
    _mindfulImage = imageService.getRandomMindfulImage();

    // set controller text to current user info
    firstNameController.text = userFirstName;
    lastNameController.text = userLastName;
    emailController.text = userEmail;
    phoneNumberController.text = userPhoneNumber;

    setFirstName(userFirstName);
    setLastName(userLastName);
    setEmail(userEmail);
    setPhoneNumber(userPhoneNumber);
  }

  // Setter methods

  void setFirstName(String value) {
    _updatedFirstName = value.trim();
    debugPrint(value);
    notifyListeners();
  }

  void setLastName(String value) {
    _updatedLastName = value.trim();
    debugPrint(value);
    notifyListeners();
  }

  void setEmail(String value) {
    _updatedEmail = value.trim();
    debugPrint(value);
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    // E164Standard phone number format expected by the backend API.
    final String phoneNumberWithCountryCode = stringService.formatPhoneNumberE164Standard(value);

    _updatedPhoneNumber = phoneNumberWithCountryCode;

    debugPrint(phoneNumberWithCountryCode);

    notifyListeners();
  }

  void setReadOnly(bool readOnly) {
    _isReadOnly = readOnly;
    notifyListeners();
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }

  Future<bool> updateUserInfo() async {
    final BaseUser updatedUser = AbstractFactory.createUser(
      userType: UserType.updatedUser,
      firstName: updatedFirstName!.toLowerCase().capitalize().trim(),
      lastName: updatedLastName!.toLowerCase().capitalize().trim(),
      email: updatedEmail!.toLowerCase().trim(),
      phoneNumber: updatedPhoneNumber!.trim(),
    );

    // attempt to update currently authenticated user
    final Response response = await userService.updateUserInfo(updatedUser);

    // check status code
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
