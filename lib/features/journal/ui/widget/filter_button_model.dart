import 'package:journal_app/app/general/constants.dart';
import 'package:stacked/stacked.dart';

class FilterButtonModel extends BaseViewModel {
  String _dropdownValue = dropdownOptions.first;

  String get dropdownValue => _dropdownValue;

  static final List<String> dropdownOptions = <String>[
    'all',
    MoodType.awesome.text,
    MoodType.happy.text,
    MoodType.okay.text,
    MoodType.bad.text,
    MoodType.terrible.text,
  ];

  void setDropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}
