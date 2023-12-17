import 'package:flutter/cupertino.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData getTheme() => ThemeData(
        // default Scaffold color is somewhat off white
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        appBarTheme: appBarTheme,
        textTheme: textTheme,
        inputDecorationTheme: inputTheme,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.lightGreen,

          // selectionColor: text highlight color
          selectionColor: AppColors.lightGreen.withOpacity(0.15),
        ),

        // change selectionHandleColor on IOS
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: AppColors.lightGreen,
        ),
        textButtonTheme: textButtonTheme,
        outlinedButtonTheme: mainButtonTheme,
        snackBarTheme: snackBarTheme,
      );
}

const AppBarTheme appBarTheme = AppBarTheme(
  // backgroundColor: AppColors.offGrey,
  // backgroundColor: AppColors.offWhite,
  backgroundColor: Colors.white,
  // shadowColor: Colors.red,
  // elevation: 1,
);

final TextTheme textTheme = TextTheme(
  // App Bar Title styling
  titleLarge: TextStyle(
    foreground: Paint()..color = AppColors.appBar,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  ),
  bodyMedium: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
);

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    // button splash color
    overlayColor: resolver((states) => AppColors.splashColor),
    textStyle: resolver((states) => TextStyle(foreground: Paint()..color = AppColors.lightGreen)),
  ),
);

// TextField and TextFormField decoration
final InputDecorationTheme inputTheme = () {
  const borderWidth = 2.5;

  debugPrint("Input theme called!");

  return const InputDecorationTheme(
    // hintStyle: appTextStyle,
    //! contentPadding: moves cursor,label text and hint text | find a way to only move the cursor
    // contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightGreen,
        width: borderWidth,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.lightGreen,
        width: borderWidth,
      ),
    ),
    floatingLabelStyle: TextStyle(color: AppColors.lightGreen),
  );
}();

const snackBarTheme = SnackBarThemeData(
  backgroundColor: AppColors.offWhite,
  contentTextStyle: snackBarTextStyle,
);

const snackBarTextStyle = TextStyle(
  fontSize: 24,
  color: AppColors.lightGreen,
);

/// borderlessInput: borderless TextField and TextFormField.
const InputDecoration borderlessInput = InputDecoration(
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  floatingLabelStyle: TextStyle(color: AppColors.lightGreen),
);

final mainButtonTheme = OutlinedButtonThemeData(style: blueButtonStyle);

final offGreyButtonTheme = OutlinedButtonThemeData(style: offGreyButtonStyle);

final lightGreenButtonTheme = OutlinedButtonThemeData(style: lightGreenButtonStyle);

final blueButtonStyle = ButtonStyle(
  shape: resolver((states) => const StadiumBorder(side: BorderSide.none)),
  side: resolver((state) => BorderSide.none),
  backgroundColor: resolver((states) => AppColors.lightGreen),
  textStyle: resolver(
    (states) => TextStyle(
      foreground: Paint()..color = AppColors.offWhite,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);

final offGreyButtonStyle = blueButtonStyle.copyWith(
  backgroundColor: resolver((state) => AppColors.offGrey.withOpacity(0.25)),
);

final lightGreenButtonStyle = blueButtonStyle.copyWith(
  backgroundColor: resolver((state) => AppColors.lightGreen),
);

/// resolver: generic helper function to shorten the call to MaterialStateProperty.resolveWith
MaterialStateProperty<T> resolver<T>(T Function(Set<MaterialState> state) statesCallback) {
  return MaterialStateProperty.resolveWith(statesCallback);
}
