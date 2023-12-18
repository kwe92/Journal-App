import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/ui/mixins/password_mixin.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel with PasswordMixin {
  String? mindfulImage;

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
    mindfulImage = imageService.getRandomMindfulImage();

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

    final bool ok = ResponseHandler.checkStatusCode(response);

    if (ok && authService.isLoggedIn) {
      userService.getCurrentUser(jsonDecode(response.body));
      await tokenService.saveTokenData(
        jsonDecode(response.body),
      );

      return ok;
    }

    return ok;
  }

  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
