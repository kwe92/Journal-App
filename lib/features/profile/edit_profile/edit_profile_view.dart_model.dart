import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends BaseViewModel {
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

  void initialize() {
    setBusy(true);
    _mindfulImage = imageService.getRandomMindfulImage();
    firstNameController.text = userFirstName;
    lastNameController.text = userLastName;
    emailController.text = userEmail;
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
}
