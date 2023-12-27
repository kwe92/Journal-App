import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? size;

  const CancelButton({
    required this.onPressed,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.close,
        size: size ?? 24,
      ),
    );
  }
}
