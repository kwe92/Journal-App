import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/features/mood/models/mood.dart';

class MoodCard extends StatelessWidget {
  final Mood mood;
  // final bool isSelected;
  final double? width;
  final double? height;
  const MoodCard({
    required this.mood,
    // required this.isSelected,
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
        color: Colors.white,
        // color: const Color(0xFFF5D7AA),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(
            height: 70,
            // color: Colors.orange,
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
    );
  }
}
