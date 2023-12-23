// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class DeleteProfileDialogViewModel extends BaseViewModel {
  // Mutable Variables
  TextEditingController _confirmedEmailControllerController = TextEditingController();

  String? _confirmedEmail;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Computed Variables
  String? get confirmedEmail => _confirmedEmail;

  GlobalKey<FormState> get formKey => _formKey;

  bool get emailMatch => confirmedEmail?.trim() == userEmail;

  User get currentUser => userService.currentUser!;

  String get userEmail => currentUser.email ?? '';

  TextEditingController get confirmedEmailController => _confirmedEmailControllerController;

  void setConfirmedEmail(String email) {
    _confirmedEmail = email;
    debugPrint('\nconfirmed email text: $email');
    notifyListeners();
  }

  String? confirmValidAndMatchingEmail(String? confirmationEmail) {
    final validationText = stringService.emailIsValid(confirmationEmail);

    return validationText ?? (confirmationEmail != userEmail ? "emails do not match" : null);
  }

  Future<bool> deleteAccount() async {
    setBusy(true);

    final Response response = await authService.deleteAccount();

    setBusy(false);

    return ResponseHandler.checkStatusCode(response);
  }
}
