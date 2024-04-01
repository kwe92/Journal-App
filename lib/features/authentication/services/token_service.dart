import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/authentication/models/token_response.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// handles managing jwt access token within encypted persistent storage.
class TokenService {
  Future<void> saveTokenData(Map<String, dynamic> responseBody) async {
    // deserialize login response body into TokenResponse
    final TokenResponse tokenResponse = TokenResponse.fromJSON(responseBody);

    debugPrint("\njwt access token: ${tokenResponse.accessToken}");

    // save access token to persistent storage
    await saveAccessTokenToStorage(tokenResponse.accessToken);
  }

  /// saves access token to persistent storage with encrypted shared preferences.
  Future<void> saveAccessTokenToStorage(String token) async {
    await storageService.write(key: PrefKeys.accessToken, value: token);
    debugPrint("\njwt access token saved successfully!");
  }

  /// retrieve access token from storage.
  Future<String?> getAccessTokenFromStorage() async {
    try {
      String? token = await storageService.read(key: PrefKeys.accessToken);
      debugPrint("\n retrieved saved jwt access token: $token");
      return token;
    } on PlatformException {
      await storageService.deleteAll();
    }

    return null;
  }

  /// remove current access token from storage.
  Future<void> removeAccessTokenFromStorage() async {
    await storageService.delete(key: PrefKeys.accessToken);
    debugPrint("\njwt access token deleted successfully!");
  }
}

// Shared Preferences && UserDefaults

//   - Shared preferences `Android` and UserDefaults `IOS`
//     are used to save key / value pairs to persistent storage on a users device
//   - saved values should not be large amounts of data

// shared preferences flutter package

//   - wraps platform-specific presistent storage for simple data
//     SharedPreferences for Android and NSUserDefaults for IOS
