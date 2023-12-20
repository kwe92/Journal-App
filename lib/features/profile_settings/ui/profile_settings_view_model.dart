import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class ProfileSettingsViewModel extends BaseViewModel {
  User get currentUser => userService.currentUser!;

  String get userFullName => "${currentUser.firstName ?? ''} ${currentUser.lastName ?? ''}";

  String get userEmail => currentUser.email ?? '';
}
