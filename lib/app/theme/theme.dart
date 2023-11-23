import 'package:diary_app/app/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
    );
  }
}

const appBarTheme = AppBarTheme(
  backgroundColor: AppColors.offGrey,
);

final textTheme = TextTheme(
  titleLarge: TextStyle(
    foreground: Paint()..color = AppColors.offWhite,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  ),
  bodyMedium: const TextStyle(
    // foreground: Paint()..color = AppColors.offWhite,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
);
