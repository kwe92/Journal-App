import 'package:flutter/cupertino.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:flutter/material.dart';

// TODO: organize and refactor theme

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

  /// return main button theme in specified color
  static OutlinedButtonThemeData customOutlinedButtonThemeData(Color? backgroundColor) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: resolver((states) => const StadiumBorder(side: BorderSide.none)),
        side: resolver((state) => BorderSide.none),
        backgroundColor: resolver((states) => backgroundColor ?? AppColors.lightGreen),
        textStyle: resolver(
          (states) => TextStyle(
            foreground: Paint()..color = AppColors.offWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
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
  titleLarge: titleLargeStyle,
  bodyMedium: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
);

final titleLargeStyle = TextStyle(
  foreground: Paint()..color = AppColors.appBar,
  fontSize: 28,
  fontWeight: FontWeight.w700,
);

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    // button splash color
    overlayColor: resolver((states) => AppColors.splashColor),
    textStyle: resolver((states) => TextStyle(foreground: Paint()..color = AppColors.lightGreen)),
  ),
);

// TextField and TextFormField decoration
const InputDecorationTheme inputTheme = InputDecorationTheme(
  // hintStyle: appTextStyle,
  //! contentPadding: moves cursor,label text and hint text | find a way to only move the cursor
  // contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.lightGreen,
      width: 2.5,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.lightGreen,
      width: 2.5,
    ),
  ),
  floatingLabelStyle: TextStyle(color: AppColors.lightGreen),
);

final InputDecorationTheme deleteAccoutInputTheme = () {
  const sharedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(
      color: AppColors.orange0,
      width: 2.5,
    ),
  );
  return const InputDecorationTheme(
    enabledBorder: sharedInputBorder,
    focusedBorder: sharedInputBorder,
    focusedErrorBorder: sharedInputBorder,
    errorBorder: sharedInputBorder,
    floatingLabelStyle: TextStyle(color: AppColors.orange0),
  );
}();

final deleteAccoutTextSelectionTheme = TextSelectionThemeData(
  cursorColor: AppColors.orange0,

  // selectionColor: text highlight color
  selectionColor: AppColors.orange0.withOpacity(0.15),
);

const snackBarTheme = SnackBarThemeData(
  backgroundColor: AppColors.offWhite,
  contentTextStyle: snackBarTextStyle,
);

const snackBarTextStyle = TextStyle(
  fontSize: 24,
  color: AppColors.lightGreen,
);

// TODO: were is this code being called? should be removed?
/// borderlessInput: borderless TextField and TextFormField.
const InputDecoration borderlessInput = InputDecoration(
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  floatingLabelStyle: TextStyle(color: AppColors.lightGreen),
);

final mainButtonTheme = OutlinedButtonThemeData(style: mainButtonStyle);

final mainButtonStyle = ButtonStyle(
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

/// resolver: generic helper function to shorten the call to MaterialStateProperty.resolveWith
MaterialStateProperty<T> resolver<T>(T Function(Set<MaterialState> state) statesCallback) {
  return MaterialStateProperty.resolveWith(statesCallback);
}
