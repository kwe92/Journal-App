import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/services/token_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/journal/services/journal_entry_service.dart';
import 'package:journal_app/features/meanings/shared/gemini_model_service.dart';
import 'package:journal_app/features/quotes/shared/services/liked_quotes_service.dart';
import 'package:journal_app/features/quotes/shared/services/zen_quotes_api_service.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// service locator global variable
final locator = GetIt.instance;

/// initalize and register all GetIt singleton services.
Future<void> configureDependencies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerSingleton<http.Client>(http.Client());
  locator.registerSingleton<UserService>(UserService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<TokenService>(TokenService());
  locator.registerSingleton<JournalEntryService>(JournalEntryService());
  locator.registerSingleton<StringService>(StringService());
  locator.registerSingleton<ToastService>(ToastService());
  locator.registerSingleton<TimeService>(TimeService());
  locator.registerSingleton<ImageService>(ImageService());
  locator.registerSingleton(MoodService());
  locator.registerSingleton<ZenQuotesApiService>(ZenQuotesApiService());
  locator.registerSingleton<LikedQuotesService>(LikedQuotesService());
  locator.registerSingleton<GeminiModelService>(GeminiModelService());

  // Persistent Storage Services
  locator.registerSingleton<SharedPreferences>(prefs);
  locator.registerFactory<FlutterSecureStorage>(() => const FlutterSecureStorage());
  locator.registerSingleton<AppModeService>(AppModeService());
}

// GetIt

//   - a singleton that acts as a service locator
//   - allows the registration and retrieval of singletons
//     with the added benifit of being easy to test
//   - traditional singletons are hard to test and require
//     alot of boiler plate code as you need to create
//     a singleton object for each service you only want to have one instace of

// FlutterSecureStorage 

//   - encypted Shared Preferences and NSUserDefaults