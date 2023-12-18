import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:stacked/stacked.dart';

// TODO: Delete User tempUser when signup complete to clean up resources

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

  // TODO: review and add comments | should it be its own endpoint on the backend so you dont have to use hashMaps
  void getCurrentUser(Map<String, dynamic> responseBody) {
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
}
