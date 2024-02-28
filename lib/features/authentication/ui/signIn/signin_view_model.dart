import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends ReactiveViewModel {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  /// Controls password obscurity.
  bool obscurePassword = true;

  bool? _isLoading;

  bool _isRemeberMeSwitchedOn = false;

  String? email;

  String? password;

  ImageProvider? mindfulImage;

  static const _readMeKey = "read_me";

  static const _emailKey = "email";

  static const _passwordKey = "password";

  /// ViewModel loading state.
  bool? get isLoading => _isLoading;

  bool get isRemeberMeSwitchedOn => _isRemeberMeSwitchedOn;

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

    final bool isRememberMeSet = await storage.containsKey(key: _readMeKey);

    debugPrint("isRememberMeSet: $isRememberMeSet");

    if (isRememberMeSet) {
      await getMemberInfoFromStorage();
    }

    // Manual Delay
    await Future.delayed(
      const Duration(milliseconds: 600),
    );

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

  void setSwitchState(bool switchedOn) {
    _isRemeberMeSwitchedOn = switchedOn;
    notifyListeners();
  }

  void setRemember(bool isSwitchedOn) async {
    _isRemeberMeSwitchedOn = isSwitchedOn;

    await saveToStorage(
      _readMeKey,
      _isRemeberMeSwitchedOn.toString(),
    );

    notifyListeners();

    debugPrint("remember me user preference saved to storage.");
  }

  Future<void> getMemberInfoFromStorage() async {
    final remeberMeOption = await storage.read(key: _readMeKey);

    debugPrint("remeberMeOption: $remeberMeOption");

    _isRemeberMeSwitchedOn = remeberMeOption!.toLowerCase() == "true";

    if (_isRemeberMeSwitchedOn) {
      await readEmailAndPasswordFromStorage();
    }

    notifyListeners();
  }

  Future<void> handleEmailAndPasswordStorage() async =>
      await runBusyFuture(_isRemeberMeSwitchedOn ? saveEmailAndPasswordToStorage() : removeEmailAndPasswordFromStorage());

  Future<void> saveEmailAndPasswordToStorage() async {
    await saveToStorage(_emailKey, email!);
    await saveToStorage(_passwordKey, password!);
    debugPrint("saved email and password to storage.");
  }

  Future<void> removeEmailAndPasswordFromStorage() async {
    await storage.delete(key: _emailKey);
    await storage.delete(key: _passwordKey);

    debugPrint("removed email and password from storage.");
  }

  Future<void> readEmailAndPasswordFromStorage() async {
    final localEmail = await storage.read(key: _emailKey);
    final localPassword = await storage.read(key: _passwordKey);

    if (localEmail != null && localPassword != null) {
      emailController.text = localEmail;
      passwordController.text = localPassword;
      email = localEmail;
      password = localPassword;
    }
  }

  Future<void> saveToStorage(String key, String value) async => await storage.write(key: key, value: value);

  /// Attempt to sign with provided email and password, returning true or false value for success or failure respectively.
  Future<bool> signInWithEmail() async {
    final Response response = await runBusyFuture(authService.login(email: email!, password: password!));

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
