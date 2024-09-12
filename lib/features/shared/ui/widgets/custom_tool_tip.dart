import 'package:flutter/material.dart';

class CustomToolTip extends StatelessWidget {
  final Color? backgroundColor;
  final String message;
  final Widget child;
  final EdgeInsets? margin;
  const CustomToolTip({
    this.backgroundColor,
    required this.message,
    required this.child,
    this.margin = const EdgeInsets.only(top: 4),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: backgroundColor ?? Colors.lightBlue, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 2),
          spreadRadius: 2,
          blurRadius: 4,
        )
      ]),
      message: message,
      child: child,
    );
  }
}
