import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';

/// ToastService: service for displaying user feedback upon success or failure of some event.
/// Info boxes displayed include toasts, snackbars, banners and other temporary infomation popup boxes
class ToastService {
  static const _genericErrorMsg = "An error has occured";

  /// showSnackBar: an information box appearing at the bottom of the users screen presisting on all views for the duration.
  void showSnackBar({String? message, BuildContext? context, Duration? duration, Color? textColor}) {
    ScaffoldMessenger.of(context ?? appRouter.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(milliseconds: 750),
        content: Text(
          message ?? _genericErrorMsg,
          textAlign: TextAlign.center,
          style: textColor != null ? snackBarTextStyle.copyWith(color: textColor) : null,
        ),
      ),
    );
  }

  /// popupMenu: a generic modal with parameters.
  Future<T> popupMenu<T>(
    BuildContext context, {
    required PopupMenuParameters parameters,
  }) async {
    return await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                titlePadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
                contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
                title: Text(
                  parameters.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, foreground: Paint()..color = AppColors.blueGrey0),
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
                                      mainTheme: offGreyButtonTheme,
                                      onPressed: () => appRouter.pop(buttonOption.value),
                                      label: buttonOption.key,
                                    ),
                                    gap12,
                                  ],
                                )
                              : SelectableButton(
                                  onPressed: () => appRouter.pop(buttonOption.value),
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

  /// popupMenu: a generic modal with parameters.
  Future<T> deleteAccountPopupMenu<T>(
    BuildContext context, {
    required String userEmail,
    required PopupMenuParameters parameters,
  }) async {
    return await showDialog(
            context: context,
            builder: (context) {
              const style00 = TextStyle(fontSize: 12);

              return SimpleDialog(
                titlePadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
                contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
                title: Text(
                  parameters.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, foreground: Paint()..color = AppColors.blueGrey0),
                ),
                children: [
                  if (parameters.content != null) ...[
                    Text(
                      parameters.content!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    gap16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'type ',
                          style: style00,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: AppColors.offGrey.withOpacity(0.15),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Text(
                            userEmail,
                            style: style00.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          ' to proceed',
                          style: style00,
                        ),
                      ],
                    ),
                    gap16,
                    Form(
                      // TODO: add form key for validation
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: deleteAccoutInputTheme,
                          textSelectionTheme: deleteAccoutTextSelectionTheme,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Confirm Email',
                          ),
                        ),
                      ),
                    ),
                    gap16,
                  ],
                  Column(
                    children: [
                      ...parameters.options.entries.mapIndexed((int index, MapEntry buttonOption) {
                        return index < parameters.options.entries.length - 1
                            ? Column(
                                children: [
                                  SelectableButton(
                                    mainTheme: offGreyButtonTheme,
                                    onPressed: () => appRouter.pop(buttonOption.value),
                                    label: buttonOption.key,
                                  ),
                                  gap12,
                                ],
                              )
                            : SelectableButton(
                                onPressed: () => appRouter.pop(buttonOption.value),
                                label: buttonOption.key,
                              );
                      }).toList()
                    ],
                  )
                ],
              );
            }) ??
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