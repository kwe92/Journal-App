import 'package:flutter/material.dart';

class ConditionalClearIcon extends StatelessWidget {
  final TextEditingController controller;
  const ConditionalClearIcon({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => controller.clear(),
        icon: const Icon(Icons.clear),
      );
}
