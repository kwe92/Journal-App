import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/token_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppRouter get appRouter {
  return locator.get<AppRouter>();
}

http.Client get client {
  return locator.get<http.Client>();
}

UserService get userService {
  return locator.get<UserService>();
}

AuthService get authService {
  return locator.get<AuthService>();
}

TokenService get tokenService {
  return locator.get<TokenService>();
}

SharedPreferences get prefs {
  return locator.get<SharedPreferences>();
}

FlutterSecureStorage get storage {
  return locator.get<FlutterSecureStorage>();
}
