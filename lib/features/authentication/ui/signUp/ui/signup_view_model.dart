import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/ui/mixins/password_mixin.dart';
import 'package:journal_app/features/shared/services/http_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel with PasswordMixin {
  bool get ready {
    return email != null &&
        email!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty &&
        confirmPassword != null &&
        confirmPassword!.isNotEmpty;
  }

  bool get passwordMatch {
    return password == confirmPassword;
  }

  void initialize() {
    setBusy(true);
    email = userService.tempUser?.email ?? "";
    setBusy(false);
  }

  String? confirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "password cannot be empty";
    } else if (value != password) {
      return "passwords do not match";
    } else {
      return null;
    }
  }

  Future<bool> signupWithEmail({required User user}) async {
    setBusy(true);
    final Response response = await authService.register(user: user);
    setBusy(false);

    switch (response.statusCode) {
      // failed status codes
      case 209 || 400 || 401 || 403 || 550:
        toastService.showSnackBar(
          message: getErrorMsg(response.body),
        );

        return false;

      // success status codes
      case 200 || 201:
        if (authService.isLoggedIn) {
          // upon successful registration retrieve jwt token from response
          await tokenService.saveTokenData(
            jsonDecode(response.body),
          );

          return true;

          // remove member info view and navigate to journal view | there maybe a better way to refresh widget
        } else {
          toastService.showSnackBar();
          return false;
        }

      default:
        toastService.showSnackBar();
        return false;
    }
  }

  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
