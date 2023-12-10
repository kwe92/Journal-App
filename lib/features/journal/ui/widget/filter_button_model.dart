import 'package:journal_app/app/general/constants.dart';
import 'package:stacked/stacked.dart';

class FilterButtonModel extends BaseViewModel {
  String dropdownValue = dropdownOptions.first;

  static final List<String> dropdownOptions = <String>[
    'all',
    MoodType.awesome,
    MoodType.happy,
    MoodType.okay,
    MoodType.bad,
    MoodType.terible,
  ];

  void setDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }
}
