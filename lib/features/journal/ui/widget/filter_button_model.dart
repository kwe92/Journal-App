import 'package:journal_app/app/general/constants.dart';
import 'package:stacked/stacked.dart';

class FilterButtonModel extends BaseViewModel {
  String? _dropdownValue;

  String? get dropdownValue => _dropdownValue;

  final dropdownOptions = <String>[
    'all',
    MoodType.awesome.text,
    MoodType.happy.text,
    MoodType.okay.text,
    MoodType.bad.text,
    MoodType.terrible.text,
  ];

  FilterButtonModel() {
    _dropdownValue = dropdownOptions.first;
  }

  void setDropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}
