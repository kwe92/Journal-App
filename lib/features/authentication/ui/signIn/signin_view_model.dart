import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends ReactiveViewModel {
  /// Controls password obscurity.
  bool obscurePassword = true;

  bool? _isLoading;

  String? email;

  String? password;

  ImageProvider? mindfulImage;

  /// ViewModel loading state.
  bool? get isLoading => _isLoading;

  bool get ready {
    return email != null && email!.isNotEmpty && password != null && password!.isNotEmpty;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        imageService,
      ];

  Future<void> initialize(BuildContext context) async {
    setLoading(true);
    await imageService.cacheImage(context);
    mindfulImage = imageService.getRandomMindfulImage();
    await ResourceCleanUp.clean();

    setLoading(false);
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setEmail(String text) {
    email = text.trim().toLowerCase();
    notifyListeners();
  }

  void setPassword(String text) {
    password = text.trim();
    notifyListeners();
  }

  void setObscure(bool isObscured) {
    obscurePassword = isObscured;
    notifyListeners();
  }

  /// Attempt to sign with provided email and password, returning true or false value for success or failure respectively.
  Future<bool> signInWithEmail(BuildContext context) async {
    setBusy(true);
    final Response response = await authService.login(email: email!, password: password!);
    setBusy(false);

    // check status code
    final bool statusOk = ResponseHandler.checkStatusCode(response);

    if (statusOk && authService.isLoggedIn) {
      // deserialize json response body
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // save the returned jwt from the response body to persistent storage
      await tokenService.saveTokenData(responseBody);

      return statusOk;
    }

    toastService.showSnackBar(
      message: ResponseHandler.getErrorMsg(response.body),
      textColor: Colors.red,
    );

    return statusOk;
  }

  void unfocusAll(BuildContext context) => toastService.unfocusAll(context);
}
