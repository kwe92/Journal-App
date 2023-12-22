import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/theme.dart';

class SelectableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? color;
  // final OutlinedButtonThemeData? customTheme;
  final EdgeInsets? labelPadding;
  final TextStyle? labelStyle;
  const SelectableButton({
    required this.onPressed,
    required this.label,
    this.color,
    this.labelPadding,
    this.labelStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        child: Ink(
          child: Theme(
            data: Theme.of(context)
                .copyWith(outlinedButtonTheme: color != null ? AppTheme.customOutlinedButtonThemeData(color) : mainButtonTheme),
            child: OutlinedButton(
              onPressed: onPressed,
              child: Padding(
                padding: labelPadding ?? const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  label,
                  style: labelStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
