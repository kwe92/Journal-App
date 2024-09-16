import 'package:flutter/cupertino.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';

//!! TODO: refactor light and dark mode

// main application theme
class AppTheme {
  const AppTheme._();

  static ThemeData getTheme(BuildContext context) {
    bool isLightMode = context.watch<AppModeService>().isLightMode;
    return ThemeData(
      colorScheme: isLightMode
          ? const ColorScheme.light()
          : const ColorScheme.dark(
              background: AppColors.darkGrey1,
            ),
      // default Scaffold color is somewhat off white
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      inputDecorationTheme: inputTheme,
      textSelectionTheme: textSelectionTheme,
      // change selectionHandleColor on IOS
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Colors.black54,
      ),
      textButtonTheme: textButtonTheme,
      outlinedButtonTheme: mainButtonTheme,
      snackBarTheme: _snackBarTheme(isLightMode),
    );
  }

  /// return main button theme in specified color
  static OutlinedButtonThemeData customOutlinedButtonThemeData(Color? backgroundColor) => OutlinedButtonThemeData(
        style: mainButtonStyle.copyWith(
          backgroundColor: resolver(
            (states) => backgroundColor ?? AppColors.mainThemeColor,
          ),
        ),
      );
  static TextSelectionThemeData getTextSelectionThemeData(Color moodColor) => textSelectionTheme.copyWith(
        // TextFormField cursor color
        cursorColor: moodColor,

        // text highlight color
        selectionColor: moodColor.withOpacity(0.15),
      );

  // TODO: not changing dynamically | research why | seems to be implemented correctly
  static NoDefaultCupertinoThemeData getCupertinoOverrideTheme(Color moodColor) => CupertinoThemeData(
        // change selectionHandleColor on IOS
        primaryColor: moodColor,
      );
}

const AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
);

const TextTheme textTheme = TextTheme(
  // App Bar Title && Calendar Body styling
  // titleLarge: titleLargeStyle,
  titleLarge: TextStyle(
    // foreground: Paint()..color = AppColors.mainThemeColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  bodyMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
);

final titleLargeStyle = TextStyle(
  foreground: Paint()..color = AppColors.mainThemeColor,
  fontSize: 28,
  fontWeight: FontWeight.w700,
);

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    // button splash color
    overlayColor: resolver((states) => AppColors.splashColor),
    textStyle: resolver((states) => TextStyle(foreground: Paint()..color = AppColors.mainThemeColor)),
  ),
);

// TextField and TextFormField decoration
const InputDecorationTheme inputTheme = InputDecorationTheme(
  // hintStyle: appTextStyle,
  //! contentPadding: moves cursor,label text and hint text | find a way to only move the cursor
  // contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.mainThemeColor,
      width: 2.5,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.mainThemeColor,
      width: 2.5,
    ),
  ),
  floatingLabelStyle: TextStyle(color: AppColors.mainThemeColor),
);

final TextSelectionThemeData textSelectionTheme = TextSelectionThemeData(
  // TextFormField cursor color
  cursorColor: AppColors.mainThemeColor,

  // text highlight color
  selectionColor: AppColors.mainThemeColor.withOpacity(0.15),
);

final InputDecorationTheme deleteAccoutInputTheme = () {
  // Create a stadium like input border by adding a border radius to OutlineInputBorder
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
  // TextFormField cursor color
  cursorColor: AppColors.orange0,

  // text highlight color
  selectionColor: AppColors.orange0.withOpacity(0.15),
);

// const snackBarTheme = SnackBarThemeData(
//   backgroundColor: AppColors.offWhite,
//   contentTextStyle: snackBarTextStyle,
// );

SnackBarThemeData _snackBarTheme(bool isLightMode) {
  return SnackBarThemeData(
    backgroundColor: isLightMode ? Colors.white : AppColors.darkGrey0,
    contentTextStyle: snackBarTextStyle,
  );
}

const snackBarTextStyle = TextStyle(
  fontSize: 24,
  color: AppColors.mainThemeColor,
);

// borderless TextField and TextFormField for entry views.
const InputDecoration borderlessInput = InputDecoration(
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  floatingLabelStyle: TextStyle(color: AppColors.mainThemeColor),
);

final mainButtonTheme = OutlinedButtonThemeData(style: mainButtonStyle);

final mainButtonStyle = ButtonStyle(
  shape: resolver((states) => const StadiumBorder(side: BorderSide.none)),
  side: resolver((state) => BorderSide.none),
  backgroundColor: resolver((states) => AppColors.mainThemeColor),
  textStyle: resolver(
    (states) => TextStyle(
      foreground: Paint()..color = AppColors.offWhite,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);

/// resolver: generic helper function to shorten the call to MaterialStateProperty.resolveWith
MaterialStateProperty<T> resolver<T>(MaterialPropertyResolver<T> statesCallback) => MaterialStateProperty.resolveWith(statesCallback);
