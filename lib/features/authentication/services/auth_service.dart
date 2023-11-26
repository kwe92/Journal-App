import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:http/http.dart' as http;

class AuthService extends ApiService with ChangeNotifier {
  Future<http.Response> register({required User user}) async {
    http.Response response = await post(
      Endpoint.register.path,
      body: jsonEncode(user.toJSON()),
    );

    return response;
  }

  Future<http.Response> login({required String email, required String password}) async {
    http.Response response = await post(
      Endpoint.login.path,
      body: jsonEncode({"email": email, "password": password}),
    );

    return response;
  }
}
