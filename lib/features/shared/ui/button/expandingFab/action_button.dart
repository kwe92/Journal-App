import 'package:flutter/material.dart';

//!! TODO: Change background color

@immutable
class ActionButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  const ActionButton({
    required this.icon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
