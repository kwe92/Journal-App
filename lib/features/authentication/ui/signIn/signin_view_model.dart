import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  String? email;
  String? password;

  // controls password obscurity
  bool obscurePassword = true;

  void setEmail(String text) {
    email = text;
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

  // TODO: toast service should be handled here
  Future<void> signInWithEmail(BuildContext context) async {
    setBusy(true);
    final Response response = await authService.login(email: email!, password: password!);
    setBusy(false);
    // TODO: add case for error in response with switch statement
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      await tokenService.saveTokenData(responseBody);
    }
  }
}
