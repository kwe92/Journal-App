import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const CustomBackButton({
    required this.onPressed,
    this.size = 32,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back_ios,
          color: color ?? AppColors.mainThemeColor,
          size: size,
        ),
      );
}
