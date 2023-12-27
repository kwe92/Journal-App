import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/journal/extensions/string_extensions.dart';
import 'package:journal_app/features/profile/edit_profile/model/updated_user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends ReactiveViewModel {
  // Mutable Variables
  String? _updatedFirstName;

  String? _updatedLastName;

  String? _updatedEmail;

  String? _mindfulImage;

  bool _readOnly = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  // Computed User Variables

  User get _currentUser => userService.currentUser!;

  String get userFirstName => _currentUser.firstName!;

  String get userLastName => _currentUser.lastName!;

  String get userEmail => _currentUser.email!;

  // Computed Update Variables

  String? get updatedFirstName => _updatedFirstName;

  String? get updatedLastName => _updatedLastName;

  String? get updatedEmail => _updatedEmail;

  bool get readOnly => _readOnly;

  // Other Computed Variables

  String? get mindfulImage => _mindfulImage;

  bool get ready =>
      _updatedFirstName != null &&
      _updatedFirstName!.isNotEmpty &&
      _updatedLastName != null &&
      _updatedLastName!.isNotEmpty &&
      _updatedEmail != null &&
      _updatedEmail!.isNotEmpty;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
      ];

  void initialize() {
    setBusy(true);

    _mindfulImage = imageService.getRandomMindfulImage();

    firstNameController.text = userFirstName;
    lastNameController.text = userLastName;
    emailController.text = userEmail;

    setFirstName(userFirstName);
    setLastName(userLastName);
    setEmail(userEmail);

    setBusy(false);
  }

  // Setter Functions

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

  void setReadOnly(bool readOnly) {
    _readOnly = readOnly;
    notifyListeners();
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
  }

  Future<bool> updateUserInfo() async {
    final UpdatedUser updatedUser = UpdatedUser(
      firstName: updatedFirstName!.toLowerCase().capitalize().trim(),
      lastName: updatedLastName!.toLowerCase().capitalize().trim(),
      email: updatedEmail!.toLowerCase().trim(),
    );

    // attempt to update the currently authenticated user
    final Response response = await userService.updateUserInfo(updatedUser);

    // check the status code
    final bool statusOk = ResponseHandler.checkStatusCode(response);

    return statusOk;
  }
}
