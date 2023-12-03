import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/mood/models/mood.dart';

class MoodTile extends StatelessWidget {
  final Mood mood;

  const MoodTile({
    required this.mood,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mood.moodColorBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            mood.moodImagePath,
            width: mood.imageSize,
            color: mood.moodColor,
          ),
          gap6,
          Text(
            mood.moodText,
            style: TextStyle(
              color: mood.moodColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
