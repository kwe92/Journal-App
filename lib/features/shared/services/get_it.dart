import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/token_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

/// configureDependencies initalizes and registers all GetIt singletons.
Future<void> configureDependencies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerSingleton<http.Client>(http.Client());
  locator.registerSingleton<UserService>(UserService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<TokenService>(TokenService());
  locator.registerSingleton<SharedPreferences>(prefs);
  locator.registerFactory<FlutterSecureStorage>(() => const FlutterSecureStorage());
}
