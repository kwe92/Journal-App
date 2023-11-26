import 'package:flutter/material.dart';
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

  Future<void> signInWithEmail(BuildContext context) async {
    setBusy(true);
    // TODO: call auth service login
    setBusy(false);
  }
}
