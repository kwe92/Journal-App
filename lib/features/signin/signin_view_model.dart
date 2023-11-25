import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// TODO: add comments

class SignInViewModel extends BaseViewModel {
  String? email;
  String? password;

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

  Future<void> signInWithEmail(BuildContext context) async {}
}
