import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';

class MoodService {
  // TODO: move default sizes to constants
  static final Map<String, MoodRecord> _moodsData = {
    MoodType.awesome: (color: AppColors.moodAwesome, imagePath: MoodImagePath.moodAwesome, defaultSize: 40.0),
    MoodType.happy: (color: AppColors.moodHappy, imagePath: MoodImagePath.moodHappy, defaultSize: 50.0),
    MoodType.okay: (color: AppColors.moodOkay, imagePath: MoodImagePath.moodOkay, defaultSize: 50.0),
    MoodType.bad: (color: AppColors.moodBad, imagePath: MoodImagePath.moodBad, defaultSize: 50.0),
    MoodType.terrible: (color: AppColors.moodTerrible, imagePath: MoodImagePath.moodTerrible, defaultSize: 70.0),
  };

  final List<MapEntry<String, MoodRecord>> moods = _moodsData.entries.toList();

  MapEntry<String, MoodRecord> getMoodByType(String moodType) {
    return moods.where((moodMap) => moodMap.key == moodType).toList().first;
  }

  MapEntry<String, MoodRecord> getMoodByIndex(int index) {
    return moods[index];
  }
}
