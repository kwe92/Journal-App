import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/profile/profile_settings/ui/delete_profile_dialog_view.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';
import 'package:provider/provider.dart';

/// Service for displaying user feedback upon success or failure of some event.
/// Info boxes displayed include toasts, snackbars, banners and other temporary infomation popup boxes.
class ToastService {
  static const _genericErrorMsg = "An error has occured";

  /// Information box appearing at the bottom of the users screen presisting on all views for the duration.
  /// If more than one snack bar is triggered the snack bar will be added to the Queue of snack bars and displayed in the order added.
  void showSnackBar({String? message, Duration? duration, Color? textColor}) {
    WidgetKey.rootScaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(milliseconds: 750),
        content: Text(
          message ?? _genericErrorMsg,
          textAlign: TextAlign.center,
          style: textColor != null ? snackBarTextStyle.copyWith(color: textColor) : null,
        ),
      ),
    );

    // ScaffoldMessenger.of(context ?? appRouter.navigatorKey.currentContext!).showSnackBar(
    //   SnackBar(
    //     duration: duration ?? const Duration(milliseconds: 750),
    //     content: Text(
    //       message ?? _genericErrorMsg,
    //       textAlign: TextAlign.center,
    //       style: textColor != null ? snackBarTextStyle.copyWith(color: textColor) : null,
    //     ),
    //   ),
    // );
  }

  /// generic modal with parameters.
  Future<T> popupMenu<T>(
    BuildContext context, {
    required Color? color,
    required PopupMenuParameters parameters,
  }) async {
    return await showDialog(
            context: context,
            builder: (context) {
              final isLightMode = context.watch<AppModeService>().isLightMode;
              return SimpleDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Colors.white,
                titlePadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
                contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
                title: Text(
                  parameters.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    foreground: Paint()..color = isLightMode ? AppColors.blueGrey0 : Colors.white,
                  ),
                ),
                children: [
                  if (parameters.content != null) ...[
                    Text(
                      parameters.content!,
                      textAlign: TextAlign.center,
                    ),
                    gap16
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ...parameters.options.entries.mapIndexed((int index, MapEntry buttonOption) {
                          return index < parameters.options.entries.length - 1
                              ? Column(
                                  children: [
                                    SelectableButton(
                                      color: AppColors.offGrey,
                                      onPressed: () => Navigator.of(context).pop(buttonOption.value),
                                      label: buttonOption.key,
                                    ),
                                    gap12,
                                  ],
                                )
                              : SelectableButton(
                                  color: color,
                                  onPressed: () => Navigator.of(context).pop(buttonOption.value),
                                  label: buttonOption.key,
                                );
                        }).toList()
                      ],
                    ),
                  )
                ],
              );
            }) ??
        parameters.defaultResult;
  }

  /// popup menu inteded for delete account flow.
  Future<T> deleteAccountPopupMenu<T>(
    BuildContext context, {
    required PopupMenuParameters parameters,
  }) async {
    return await showDialog(
          context: context,
          builder: (context) => DeleteProfileDialogView(parameters: parameters),
        ) ??
        parameters.defaultResult;
  }

  void unfocusAll(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}



// ScaffoldMessenger

//   - API's for showing snackbars and banners
//   - Sits at the top of the widget tree bellow the Material App and above all Scaffolds

// Collecting the Result of a Modal Event

//   - pass an argument to appRouter.pop or Navigator.of(context).pop to send a result to the caller
//   - typically used when you want to collect a result from the user after some modal event