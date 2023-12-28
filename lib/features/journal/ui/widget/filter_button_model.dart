import 'package:journal_app/app/general/constants.dart';
import 'package:stacked/stacked.dart';

class FilterButtonModel extends BaseViewModel {
  String _dropdownValue = dropdownOptions.first;

  String get dropdownValue => _dropdownValue;

  static final List<String> dropdownOptions = <String>[
    'all',
    MoodType.awesome,
    MoodType.happy,
    MoodType.okay,
    MoodType.bad,
    MoodType.terrible,
  ];

  void setDropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}
