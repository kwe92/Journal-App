import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  String? email;
  String? password;
  String? mindfulImage;

  bool get ready {
    return email != null && email!.isNotEmpty && password != null && password!.isNotEmpty;
  }

  // controls password obscurity
  bool obscurePassword = true;

  void initialize() async {
    mindfulImage = imageService.getRandomMindfulImage();

    await ResourceCleanUp.clean();
  }

  void setEmail(String text) {
    email = text.trim().toLowerCase();
    notifyListeners();
  }

  void setPassword(String text) {
    password = text;
    notifyListeners();
  }

  void setObscure(bool isObscured) {
    obscurePassword = isObscured;

    notifyListeners();
  }

  /// attempt to sign with the provided email and password providing a true or false value for success or failure respectively
  Future<bool> signInWithEmail(BuildContext context) async {
    setBusy(true);
    final Response response = await authService.login(email: email!, password: password!);
    setBusy(false);

    // check status code
    final bool ok = ResponseHandler.checkStatusCode(response);

    if (ok && authService.isLoggedIn) {
      // deserialize json response body
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // save the returned jwt from the response body to persistent storage
      await tokenService.saveTokenData(responseBody);

      return ok;
    }

    toastService.showSnackBar(
      message: ResponseHandler.getErrorMsg(response.body),
      textColor: Colors.red,
    );

    return ok;
  }

  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
