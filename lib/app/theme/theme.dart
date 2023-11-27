import 'package:flutter/cupertino.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:flutter/material.dart';

// TODO: Add Comments

class AppTheme {
  const AppTheme._();

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      inputDecorationTheme: inputTheme,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.blue1,
        // selectionColor: text highlight color
        selectionColor: AppColors.blue1.withOpacity(0.15),
      ),
      // change selectionHandleColor on IOS
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.blue1,
      ),
      textButtonTheme: textButtonTheme,
      outlinedButtonTheme: mainButtonTheme,
    );
  }
}

const AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: AppColors.offGrey,
);

final TextTheme textTheme = TextTheme(
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

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith(
      // button splash color
      (states) => AppColors.splashColor,
    ),
    textStyle: MaterialStateProperty.resolveWith(
      (states) => TextStyle(foreground: Paint()..color = AppColors.blue1),
    ),
  ),
);

final InputDecorationTheme inputTheme = () {
  const borderWidth = 2.5;

  debugPrint("Input theme called!");

  return const InputDecorationTheme(
    // hintStyle: appTextStyle,
    //! contentPadding: moves cursor,label text and hint text | find a way to only move the cursor
    // contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        // color: AppColors.blue1,
        color: AppColors.blue1,

        width: borderWidth,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.blue1,
        width: borderWidth,
      ),
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.blue1,
    ),
  );
}();

const InputDecoration borderlessInput = InputDecoration(
  // hintStyle: appTextStyle,
  //! contentPadding: moves cursor,label text and hint text | find a way to only move the cursor
  // contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  floatingLabelStyle: TextStyle(
    color: AppColors.blue1,
  ),
);

final mainButtonTheme = OutlinedButtonThemeData(style: blueButtonStyle);

final offGreyButtonTheme = OutlinedButtonThemeData(style: offGreyButtonStyle);

final blueButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.resolveWith(
    (states) => const StadiumBorder(side: BorderSide.none),
  ),
  backgroundColor: MaterialStateProperty.resolveWith(
    (states) => AppColors.blue1,
  ),
  textStyle: MaterialStateProperty.resolveWith(
    (states) => TextStyle(
      foreground: Paint()..color = AppColors.offWhite,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);

final offGreyButtonStyle = blueButtonStyle.copyWith(
  backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.offGrey),
);
