import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';

class MoodTypeCounter extends StatelessWidget {
  final String moodType;
  final int moodCount;

  const MoodTypeCounter({
    required this.moodType,
    required this.moodCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SvgPicture.asset(
            MoodsData.moodsData[moodType]!.imagePath,
            height: moodType == MoodType.terrible ? 25 : 20,
            color: MoodsData.moodsData[moodType]!.color,
          ),
          moodType == MoodType.terrible ? gap2 : gap4,
          Text(
            "$moodCount",
            style: const TextStyle(
              color: AppColors.offGrey,
              fontSize: 12,
            ),
          ),
        ],
      );
}
