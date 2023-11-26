import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:stacked/stacked.dart';

class UserService extends ApiService with ListenableServiceMixin, ChangeNotifier {
  User? user;

  User? tempUser;

  /// Create a temporary user that will be updated during onboarding
  /// If a temp user already exists, keep that
  Future<void> createTempUser() async {
    tempUser = User();
  }
}
