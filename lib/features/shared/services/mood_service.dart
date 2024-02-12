import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';

/// Encapsulates all data associated with mood type and provides methods for retrieving various mood data.
class MoodService {
  static const double commonDefaultSize = 50.0;

  static const double moodAwesomeDefaultSize = 40.0;

  static const double moodTerribleDefaultSize = 70.0;

  static final Map<String, MoodRecord> _moodsData = {
    MoodType.awesome.text: (color: AppColors.moodAwesome, imagePath: MoodImagePath.moodAwesome, defaultSize: moodAwesomeDefaultSize),
    MoodType.happy.text: (color: AppColors.moodHappy, imagePath: MoodImagePath.moodHappy, defaultSize: commonDefaultSize),
    MoodType.okay.text: (color: AppColors.moodOkay, imagePath: MoodImagePath.moodOkay, defaultSize: commonDefaultSize),
    MoodType.bad.text: (color: AppColors.moodBad, imagePath: MoodImagePath.moodBad, defaultSize: commonDefaultSize),
    MoodType.terrible.text: (color: AppColors.moodTerrible, imagePath: MoodImagePath.moodTerrible, defaultSize: moodTerribleDefaultSize),
  };

  final List<MapEntry<String, MoodRecord>> moods = _moodsData.entries.toList();

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

  // TODO: Refactor moodType to  ModeType Enum

  Color getMoodColorByType(String moodType) {
    final MoodRecord moodData = _moodsData[moodType]!;

    return moodData.color;
  }
}
