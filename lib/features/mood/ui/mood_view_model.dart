import 'package:journal_app/app/general/constants.dart';
import 'package:stacked/stacked.dart';

class MoodViewModel extends BaseViewModel {
  // default mood to awesome
  int selectedIndex = 0;

  // default moodType to awesome
  String moodType = MoodType.awesome;

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setMoodType(String moodType) {
    this.moodType = moodType;
    notifyListeners();
  }
}
