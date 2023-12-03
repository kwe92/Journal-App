import 'package:flutter/material.dart';

class Mood {
  final Color moodColor;
  final String moodImagePath;
  final double imageSize;
  final String moodText;

  Color get moodColorBackground {
    return moodColor.withOpacity(0.15);
  }

  const Mood({
    required this.moodColor,
    required this.moodImagePath,
    required this.imageSize,
    required this.moodText,
  });
}
