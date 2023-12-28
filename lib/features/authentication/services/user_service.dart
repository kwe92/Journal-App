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
  UserService();

  User? _tempUser;

  User? _currentUser;

  User? get tempUser => _tempUser;

  User? get currentUser => _currentUser;

  /// Create a temporary user that will be updated during onboarding
  /// If a temp user already exists, keep that
  Future<void> createTempUser() async {
    _tempUser = User();

    debugPrint("\ntemporary user created.");

    notifyListeners();
  }

  /// Set the currently authenticated User object
  void setCurrentUser(Map<String, dynamic> responseBody) {
    final Map<String, dynamic> currentUserMap = responseBody['user'];

    // TODO: should be its own DTO | maybe create an abstract User class
    _currentUser = User(
      firstName: currentUserMap['first_name'],
      lastName: currentUserMap['last_name'],
      email: currentUserMap['email'],
      phoneNumber: currentUserMap['phone_number'],
    );

    debugPrint("\nCurrent User Object: $_currentUser");

    notifyListeners();
  }

  // update currently authenticated and loggedin user info
  Future<http.Response> updateUserInfo(UpdatedUser updatedUser) async {
    // retrieve access token that was saved when the user logged in or registered
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      userService.setCurrentUser(jsonDecode(response.body));
    }

    return response;
  }

  /// set state of UserService properties to null
  void clearUserData() {
    _tempUser = null;
    _currentUser = null;
    notifyListeners();
  }

  /// set state of tempUser to null
  void clearTempUserData() {
    _tempUser = null;
    notifyListeners();
    debugPrint("\ntemporary user data cleared.");
  }

  void setTempUserFirstName(String val) {
    userService._tempUser?.firstName = val;
    notifyListeners();
  }

  void setTempUserLastName(String val) {
    userService._tempUser?.lastName = val;
    notifyListeners();
  }

  void setTempUserEmail(String val) {
    userService._tempUser?.email = val;
    notifyListeners();
  }

  void setTempUserPhoneNumber(String val) {
    userService._tempUser?.phoneNumber = val;
    notifyListeners();
  }

  void setTempUserPassword(String val) {
    userService._tempUser?.password = val;

    notifyListeners();
  }
}
