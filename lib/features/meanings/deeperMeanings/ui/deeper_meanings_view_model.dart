import 'package:journal_app/features/meanings/deeperMeanings/utils/prompt_data.dart';
import 'package:stacked/stacked.dart';

class DeeperMeaningsViewModel extends BaseViewModel {
  bool _isVisible = true;

  List<String> _prompts = [];

  bool get isVisible => _isVisible;

  List<String> get prompts => _prompts;

  DeeperMeaningsViewModel() {
    _prompts = getShuffledPrompts();
  }

  void setVisibility(bool isVisible) {
    _isVisible = isVisible;
    notifyListeners();
  }
}
