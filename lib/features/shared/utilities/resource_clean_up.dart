// clean up resources when the user logs out
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// cleans up global resources.
class ResourceCleanUp {
  const ResourceCleanUp._();

  static Future<void> clean() async {
    // remove access token upon user logout
    await tokenService.removeAccessTokenFromStorage();

    // clear stored user data
    userService.clearUserData();

    debugPrint("all globally stored resources have been cleaned up.");
  }
}
