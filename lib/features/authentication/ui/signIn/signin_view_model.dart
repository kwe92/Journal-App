import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/http_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
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

    switch (response.statusCode) {
      case 209 || 400 || 401 || 403 || 550:
        toastService.showSnackBar(
          message: getErrorMsg(response.body),
        );
        return false;
    }

    if (response.statusCode == 200 || response.statusCode == 201 && authService.isLoggedIn) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      await tokenService.saveTokenData(responseBody);
      return true;
    } else {
      return false;
    }
  }

  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
