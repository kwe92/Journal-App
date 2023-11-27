import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/authentication/models/token_response.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// TokenService: handles managing access token within encypted persistent storage.
class TokenService {
  Future<void> saveTokenData(Map<String, dynamic> responseBody) async {
    // deserialize login response body into TokenResponse
    final TokenResponse tokenResponse = TokenResponse.fromJSON(responseBody);

    debugPrint("\njwt access token: ${tokenResponse.accessToken}");

    await saveAccessTokenToStorage(tokenResponse.accessToken);
  }

  /// saveAccessTokenToStorage: save access token to persisent storage with encrypted shared preferences.
  Future<void> saveAccessTokenToStorage(String token) async {
    await storage.write(key: PrefKeys.accessToken, value: token);
    debugPrint("\njwt access token saved successfully!");
  }

  /// getAccessTokenFromStorage: retrieve access token from storage.
  Future<String?> getAccessTokenFromStorage() async {
    try {
      String? token = await storage.read(key: PrefKeys.accessToken);
      debugPrint("\nsaved jwt access token: $token");
      return token;
    } on PlatformException {
      await storage.deleteAll();
    }

    return null;
  }

  /// removeAccessTokenFromStorage: remove  current access token from storage.
  Future<void> removeAccessTokenFromStorage() async {
    await storage.delete(key: PrefKeys.accessToken);
    debugPrint("\njwt access token deleted successfully!");
  }
}

// Shared Preferences && UserDefaults

//   - Shared preferences `Android` and UserDefaults `IOS`
//     are used to save key / values pairs to persistent storage on a users device
//   - saved values should not be large amounts of data

// shared preferences flutter package

//   - wraps platform-specific presistent storage for simple data
//     SharedPreferences for Android and NSUserDefaults for IOS
