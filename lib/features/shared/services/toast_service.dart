import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';

/// ToastService: service for displaying user feedback upon success or failure of some event.
/// Info boxes displayed include toasts, snackbars, banners and other temporary infomation popup boxes
class ToastService {
  static const _genericErrorMsg = "An error has occured";

  /// showSnackBar: an information box appearing at the bottom of the users screen presisting on all views for the duration.
  void showSnackBar({String? message, BuildContext? context}) {
    ScaffoldMessenger.of(context ?? appRouter.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message ?? _genericErrorMsg,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // TODO: implement modal as popUpMenu
  // TODO: add modal popup parameters
  // TODO: style modal

  Future<T> popupMenu<T>(
    BuildContext context, {
    required PopupMenuParameters parameters,
  }) async {
    return await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
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
                                      onPressed: () {
                                        appRouter.pop(buttonOption.value);
                                      },
                                      label: buttonOption.key,
                                    ),
                                    gap12,
                                  ],
                                )
                              : SelectableButton(
                                  onPressed: () {
                                    appRouter.pop(buttonOption.value);
                                  },
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
}



// ScaffoldMessenger

//   - API's for showing snackbars and banners
//   - Sits at the top of the widget tree bellow the Material App and above all Scaffolds
