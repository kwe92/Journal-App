import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:stacked/stacked.dart';

class MoodViewModel extends BaseViewModel {
  int selectedIndex = 0;

  String moodType = MoodType.awesome;

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setMoodType(String moodType) {
    this.moodType = moodType;
    debugPrint(moodType);
    notifyListeners();
  }
}
