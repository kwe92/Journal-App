import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';

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
}

// ScaffoldMessenger

//   - API's for showing snackbars and banners
//   - Sits at the top of the widget tree bellow the Material App and above all Scaffolds