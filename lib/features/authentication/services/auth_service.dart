import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:http/http.dart' as http;

/// AuthService: authorization service that commincates with backend for user authorization.
class AuthService extends ApiService with ChangeNotifier {
  bool isLoggedIn = false;

  /// register: registers a user via API call to backend.
  Future<http.Response> register({required User user}) async {
    http.Response response = await post(
      Endpoint.register.path,
      body: jsonEncode(user.toJSON()),
    );

    if (response.statusCode == 200) {
      isLoggedIn = true;
      notifyListeners();
    }

    return response;
  }

  /// login: login a user via API call to backend.
  Future<http.Response> login({required String email, required String password}) async {
    http.Response response = await post(
      Endpoint.login.path,
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );

    if (response.statusCode == 200) {
      isLoggedIn = true;
      notifyListeners();
    }

    return response;
  }

  /// checks backend database to ensure the email is available
  Future<http.Response> checkAvailableEmail({required String email}) async {
    http.Response response = await post(
      Endpoint.checkAvailableEmail.path,
      body: jsonEncode(
        {"email": email},
      ),
    );

    return response;
  }
}
