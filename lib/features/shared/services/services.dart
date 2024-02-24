import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/services/token_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/journal/services/journal_entry_service.dart';
import 'package:journal_app/features/meanings/shared/gemini_model_service.dart';
import 'package:journal_app/features/quotes/shared/services/liked_quotes_service.dart';
import 'package:journal_app/features/quotes/shared/services/zen_quotes_api_service.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';
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

JournalEntryService get journalEntryService {
  return locator.get<JournalEntryService>();
}

StringService get stringService {
  return locator.get<StringService>();
}

ToastService get toastService {
  return locator.get<ToastService>();
}

TimeService get timeService {
  return locator.get<TimeService>();
}

ImageService get imageService {
  return locator.get<ImageService>();
}

TokenService get tokenService {
  return locator.get<TokenService>();
}

MoodService get moodService {
  return locator.get<MoodService>();
}

// Persistent Storage Services

SharedPreferences get prefs {
  return locator.get<SharedPreferences>();
}

FlutterSecureStorage get storage {
  return locator.get<FlutterSecureStorage>();
}

ZenQuotesApiService get zenQuotesApiService {
  return locator.get<ZenQuotesApiService>();
}

LikedQuotesService get likedQuotesService {
  return locator.get<LikedQuotesService>();
}

AppModeService get appModeService {
  return locator.get<AppModeService>();
}

GeminiModelService get geminiModelService {
  return locator.get<GeminiModelService>();
}
