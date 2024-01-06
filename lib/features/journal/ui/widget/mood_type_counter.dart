// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:stacked/stacked.dart';

class MoodTypeCounter extends ViewModelWidget<JournalViewModel> {
  final String moodType;
  final int moodCount;

  const MoodTypeCounter({
    required this.moodType,
    required this.moodCount,
    super.key,
  });

  @override
  Widget build(BuildContext context, JournalViewModel viewModel) {
    final Mood mood = viewModel.createMood(moodType, 20);
    return Row(
      children: [
        SvgPicture.asset(
          mood.moodImagePath,
          height: moodType == MoodType.terrible ? 25 : 20,
          color: mood.moodColor,
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
}
