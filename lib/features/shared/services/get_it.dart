import 'package:journal_app/app/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';

final locator = GetIt.instance;

/// configureDependencies initalizes and registers all GetIt singletons.
void configureDependencies() {
  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerSingleton<http.Client>(http.Client());
  locator.registerSingleton<UserService>(UserService());
  locator.registerSingleton<AuthService>(AuthService());
}
