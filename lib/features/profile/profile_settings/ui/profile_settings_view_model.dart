// ignore_for_file: prefer_final_fields

import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class ProfileSettingsViewModel extends ReactiveViewModel {
  User? get currentUser {
    return userService.currentUser;
  }

  String get userFullName => "${currentUser?.firstName ?? ''} ${currentUser?.lastName ?? ''}";

  String get userEmail => currentUser?.email ?? '';

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
      ];
}
