import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';

/// Encapsulates all data associated with mood type.
class MoodService {
  static const double commonDefaultSize = 50.0;

  static const double moodAwesomeDefaultSize = 40.0;

  static const double moodTerribleDefaultSize = 70.0;

  static final Map<String, MoodRecord> _moodsData = {
    MoodType.awesome: (color: AppColors.moodAwesome, imagePath: MoodImagePath.moodAwesome, defaultSize: moodAwesomeDefaultSize),
    MoodType.happy: (color: AppColors.moodHappy, imagePath: MoodImagePath.moodHappy, defaultSize: commonDefaultSize),
    MoodType.okay: (color: AppColors.moodOkay, imagePath: MoodImagePath.moodOkay, defaultSize: commonDefaultSize),
    MoodType.bad: (color: AppColors.moodBad, imagePath: MoodImagePath.moodBad, defaultSize: commonDefaultSize),
    MoodType.terrible: (color: AppColors.moodTerrible, imagePath: MoodImagePath.moodTerrible, defaultSize: moodTerribleDefaultSize),
  };

  final List<MapEntry<String, MoodRecord>> moods = _moodsData.entries.toList();

  // TODO: refactor to return a map for testing
  MapEntry<String, MoodRecord> getMoodByType(String moodType) {
    return moods.where((moodMap) => moodMap.key == moodType).toList().first;
  }

  MapEntry<String, MoodRecord> getMoodByIndex(int index) {
    return moods[index];
  }
}
