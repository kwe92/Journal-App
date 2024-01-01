import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/authentication/ui/mixins/password_mixin.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends ReactiveViewModel with PasswordMixin {
  ImageProvider? _mindfulImage;

  ImageProvider? get mindfulImage => _mindfulImage;

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

  bool get passwordCriteriaSatisfied => _passwordCriteriaSatisfied();

  @override
  List<ListenableServiceMixin> get listenableServices => [imageService];

  void initialize(BuildContext context) async {
    _mindfulImage = imageService.getRandomMindfulImage();

    email = userService.tempUser?.email ?? "";
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

  /// determines if the password criteria was met.
  bool _passwordCriteriaSatisfied() {
    final String? allSatisfied = stringService.passwordIsValid(password);
    return allSatisfied != null && allSatisfied.isNotEmpty ? false : true;
  }

  // register user with email if available
  Future<bool> signupWithEmail({required BaseUser user}) async {
    final Response response = await runBusyFuture(authService.register(user: user));

    // indicate if request was successful
    final bool statusOk = ResponseHandler.checkStatusCode(response);

    if (statusOk && authService.isLoggedIn) {
      // set currently authenticated user
      userService.setCurrentUser(jsonDecode(response.body));

      // clear temp user dat
      userService.clearTempUserData();

      // save jwt token to persistent storage
      await tokenService.saveTokenData(
        jsonDecode(response.body),
      );

      return statusOk;
    }

    toastService.showSnackBar(
      message: ResponseHandler.getErrorMsg(response.body),
      textColor: Colors.red,
    );

    return statusOk;
  }

  // unfocus currently focused nodes
  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
