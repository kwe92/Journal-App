import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';

class CustomToolTip extends StatelessWidget {
  final String message;
  final Widget child;
  final EdgeInsets? margin;
  const CustomToolTip({
    required this.message,
    required this.child,
    this.margin = const EdgeInsets.only(top: 4),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isLightMode = context.watch<AppModeService>().isLightMode;

    return Tooltip(
      margin: margin,
      textStyle: TextStyle(
        color: isLightMode ? Colors.black : Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      message: message,
      child: child,
    );
  }
}
