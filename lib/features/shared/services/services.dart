import 'package:http/http.dart' as http;
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';

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
