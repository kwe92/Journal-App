import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';

/// PrefKeys: shared preference keys.
class PrefKeys {
  const PrefKeys._();

  static const accessToken = "jwt";
}

class MediaType {
  const MediaType._();
  static const json = "application/json";
}

class MoodType {
  const MoodType._();

  static const String awesome = "Awesome";
  static const String happy = "Happy";
  static const String okay = "Okay";
  static const String bad = "Bad";
  static const String terible = "Terible";
}

class MoodImagePath {
  const MoodImagePath._();
  static const String moodAwesome = "assets/images/very_happy_face.svg";
  static const String moodHappy = "assets/images/happy_face.svg";
  static const String moodOkay = "assets/images/meh_face.svg";
  static const String moodBad = "assets/images/sad_face.svg";
  static const String moodTerible = "assets/images/aweful_face.svg";
}

class MoodsData {
  const MoodsData._();

  static final Map<String, MoodRecord> moodsData = {
    MoodType.awesome: (color: AppColors.moodAwesome, imagePath: MoodImagePath.moodAwesome, defaultSize: 40.0),
    MoodType.happy: (color: AppColors.moodHappy, imagePath: MoodImagePath.moodHappy, defaultSize: 50.0),
    MoodType.okay: (color: AppColors.moodOkay, imagePath: MoodImagePath.moodOkay, defaultSize: 50.0),
    MoodType.bad: (color: AppColors.moodBad, imagePath: MoodImagePath.moodBad, defaultSize: 50.0),
    MoodType.terible: (color: AppColors.moodTerible, imagePath: MoodImagePath.moodTerible, defaultSize: 70.0),
  };

  static final List<MapEntry<String, MoodRecord>> moodsMaps = moodsData.entries.toList();

  static MapEntry<String, MoodRecord> getMoodDataByType(String moodType) {
    return moodsMaps.where((moodMap) => moodMap.key == moodType).toList().first;
  }
}
