import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/profile/edit_profile/model/updated_user.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class UserService extends ApiService with ListenableServiceMixin, ChangeNotifier {
  User? user;

  User? tempUser;

  User? currentUser;

  /// Create a temporary user that will be updated during onboarding
  /// If a temp user already exists, keep that
  Future<void> createTempUser() async {
    tempUser = User();
    notifyListeners();
  }

  /// Set the currently authenticated User object
  void setCurrentUser(Map<String, dynamic> responseBody) {
    final Map<String, dynamic> currentUserMap = responseBody['user'];

    currentUser = User(
      firstName: currentUserMap['first_name'],
      lastName: currentUserMap['last_name'],
      email: currentUserMap['email'],
      phoneNumber: currentUserMap['phone_number'],
    );

    debugPrint("\nCurrent User Object: $currentUser");

    notifyListeners();
  }

  // update currently loggedin user info
  Future<http.Response> updateUserInfo(UpdatedUser updatedUser) async {
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await post(
      Endpoint.updateUserInfo.path,
      extraHeaders: {
        HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
      },
      body:
          // serialize object into JSON string
          jsonEncode(updatedUser.toJSON()),
    );

    return response;
  }

  void clearUserData() {
    user = null;
    tempUser = null;
    currentUser = null;
    notifyListeners();
  }

  void clearTempUserData() {
    tempUser = null;
    notifyListeners();
    debugPrint("\ntemporary user data cleared.");
  }
}
