import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/shared/services/services.dart';

/// authentication service that commincates with backend for user authorization.
class AuthService extends ApiService with ChangeNotifier {
  bool _isLoggedIn = false;

  /// represents if current user is properly authenticated and loggedin
  bool get isLoggedIn => _isLoggedIn;

  /// registers a user via API call to backend.
  Future<http.Response> register({required User user}) async {
    final http.Response response = await post(
      Endpoint.register.path,
      body: jsonEncode(user.toJSON()),
    );

    if (response.statusCode == 200) {
      _isLoggedIn = true;
      notifyListeners();
    }

    return response;
  }

  /// login: login a user via API call to backend.
  Future<http.Response> login({required String email, required String password}) async {
    final http.Response response = await post(
      Endpoint.login.path,
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );

    if (response.statusCode == 200) {
      userService.setCurrentUser(jsonDecode(response.body));
      _isLoggedIn = true;
      notifyListeners();
    }

    return response;
  }

  /// checks backend database to ensure the specified email is available
  Future<http.Response> checkAvailableEmail({required String email}) async {
    final http.Response response = await post(
      Endpoint.checkAvailableEmail.path,
      body: jsonEncode(
        {"email": email},
      ),
    );

    return response;
  }

  /// PERMANENTLY deletes ALL user data and associations from backend database
  Future<http.Response> deleteAccount() async {
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await delete(Endpoint.deleteAccount.path, extraHeaders: {
      HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    });
    return response;
  }
}
