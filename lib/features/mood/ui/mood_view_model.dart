import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class MoodViewModel extends BaseViewModel {
  // default mood to awesome
  int _selectedIndex = 0;

  // default moodType to awesome
  String _moodType = MoodType.awesome;

  String get moodType => _moodType;

  int get selectedIndex => _selectedIndex;

  List<MapEntry<String, MoodRecord>> get moods => moodService.moods;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setMoodType(String mood) {
    _moodType = mood;
    notifyListeners();
  }
}
