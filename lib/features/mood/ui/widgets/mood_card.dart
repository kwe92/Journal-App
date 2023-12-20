import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';

class MoodCard extends StatelessWidget {
  final Mood mood;
  final bool isSelected;
  final double? width;
  final double? height;
  const MoodCard({
    required this.mood,
    required this.isSelected,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: mood.moodColor) : null,
        color: Colors.white,
        boxShadow: const [
          CommonBoxShadow(),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? mood.moodColorBackground : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              child: SvgPicture.asset(
                mood.moodImagePath,
                width: mood.imageSize,
                color: mood.moodColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                mood.moodText,
                style: TextStyle(color: mood.moodColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
