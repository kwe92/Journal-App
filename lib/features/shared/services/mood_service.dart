import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';

/// Encapsulates all data associated with mood type and provides methods for retrieving various mood data.
class MoodService {
  static const _commonDefaultSize = 50.0;

  static const _moodAwesomeDefaultSize = 40.0;

  static const _moodTerribleDefaultSize = 70.0;

  static final _moodsData = {
    MoodType.awesome.text: (color: AppColors.moodAwesome, imagePath: MoodImagePath.moodAwesome, defaultSize: _moodAwesomeDefaultSize),
    MoodType.happy.text: (color: AppColors.moodHappy, imagePath: MoodImagePath.moodHappy, defaultSize: _commonDefaultSize),
    MoodType.okay.text: (color: AppColors.moodOkay, imagePath: MoodImagePath.moodOkay, defaultSize: _commonDefaultSize),
    MoodType.bad.text: (color: AppColors.moodBad, imagePath: MoodImagePath.moodBad, defaultSize: _commonDefaultSize),
    MoodType.terrible.text: (color: AppColors.moodTerrible, imagePath: MoodImagePath.moodTerrible, defaultSize: _moodTerribleDefaultSize),
  };

  static final _moodsEntries = _moodsData.entries.toList();

  final moods = _moodsEntries
      .map(
        (moodData) => Mood(
            moodColor: moodData.value.color,
            moodImagePath: moodData.value.imagePath,
            imageSize: moodData.value.defaultSize,
            moodText: moodData.key),
      )
      .toList();

  // abstractions provided to make accessing mood data easier

  Mood createMoodByType(String moodType, [double? imageSize]) {
    // final MapEntry<String, MoodRecord> moodData = moods.where((moodMap) => moodMap.key == moodType).toList().first;

    final MoodRecord moodRecord = _moodsData[moodType]!;

    final Mood mood = Mood(
      moodColor: moodRecord.color,
      moodImagePath: moodRecord.imagePath,
      imageSize: imageSize ?? moodRecord.defaultSize,
      moodText: moodType,
    );
    return mood;
  }

  Color getMoodColorByType(String moodType) {
    final MoodRecord moodData = _moodsData[moodType]!;

    return moodData.color;
  }
}
