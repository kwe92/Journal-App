import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const CustomBackButton({
    required this.onPressed,
    this.size = 32,
    super.key,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: size,
        ),
      );
}
