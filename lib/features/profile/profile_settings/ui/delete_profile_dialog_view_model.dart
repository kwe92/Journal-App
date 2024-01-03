// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class DeleteProfileDialogViewModel extends BaseViewModel {
  final TextEditingController confirmedEmailController = TextEditingController();

  // Mutable Variables

  String? _confirmedEmail;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Computed Variables
  String? get confirmedEmail => _confirmedEmail;

  GlobalKey<FormState> get formKey => _formKey;

  bool get emailMatch => confirmedEmail?.trim() == userEmail;

  BaseUser? get currentUser => userService.currentUser;

  String get userEmail => currentUser?.email ?? '';

  void setConfirmedEmail(String email) {
    _confirmedEmail = email;
    debugPrint('\nconfirmed email text: $email');
    notifyListeners();
  }

  String? confirmValidAndMatchingEmail(String? confirmationEmail) {
    final validationText = stringService.emailIsValid(confirmationEmail);

    return validationText ?? (confirmationEmail != userEmail ? "emails do not match" : null);
  }

  /// PERMANENTLY delete ALL user data
  Future<bool> deleteAccount() async {
    final Response response = await runBusyFuture(authService.deleteAccount());

    // check response status code
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

  Future<void> cleanResources() async {
    await ResourceCleanUp.clean();
  }
}
