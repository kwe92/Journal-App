import 'package:flutter/material.dart';

class JournalContent extends StatelessWidget {
  final VoidCallback onPressed;

  final Color moodBackgroundColor;

  final String content;

  // TODO: maybe add CustomBoxShadow?

  const JournalContent({
    required this.onPressed,
    required this.moodBackgroundColor,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 150,
          maxHeight: 250,
          minWidth: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: moodBackgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              // padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

              child: Text(
                content,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
