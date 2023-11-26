import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// TokenService: handles saving access token to storage and removing from storage
class TokenService {
  Future<void> saveTokenData(String responseBody) async {
    _TokenResponse tokenResponse = _TokenResponse.fromJson(responseBody);

    debugPrint("\njwt access token: ${tokenResponse.accessToken}\n");

    await saveAccessTokenToStorage(tokenResponse.accessToken);
  }

  Future<void> saveAccessTokenToStorage(String token) async {
    await storage.write(key: _PrefKeys.accessToken, value: token);
  }

  Future<String?> getAccessTokenFromStorage() async {
    try {
      String? token = await storage.read(key: _PrefKeys.accessToken);
      debugPrint("\n\saved jwt access token: $token\n");
      return token;
    } on PlatformException {
      await storage.deleteAll();
    }

    return null;
  }

  /// Remove the current access token stored in secure storage
  Future<void> removeAccessTokenFromStorage() async {
    await storage.delete(key: _PrefKeys.accessToken);
  }
}

class _TokenResponse {
  final String accessToken;
  const _TokenResponse({required this.accessToken});

  factory _TokenResponse.fromMap(Map<String, dynamic> map) {
    return _TokenResponse(
      accessToken: map['jwt'] ?? '',
    );
  }

  factory _TokenResponse.fromJson(String source) => _TokenResponse.fromMap(json.decode(source));
}

class _PrefKeys {
  const _PrefKeys();

  static const accessToken = "jwt";
}
