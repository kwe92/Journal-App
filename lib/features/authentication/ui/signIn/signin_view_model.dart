import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';
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

  void initialize() {
    mindfulImage = imageService.getRandomMindfulImage();
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

  Future<bool> signInWithEmail(BuildContext context) async {
    setBusy(true);
    final Response response = await authService.login(email: email!, password: password!);
    setBusy(false);

    final bool ok = ResponseHandler.checkStatusCode(response);

    if (ok && authService.isLoggedIn) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      await tokenService.saveTokenData(responseBody);
      return ok;
    }
    return ok;
  }

  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
