import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class PromptsViewModel extends BaseViewModel {
  String _promptText;

  bool _disposed = false;

  String? get promptTextResponse => geminiModelService.promptTextResponse;

  List<Content> get _content => [Content.text("What is ${_promptText.toLowerCase()}?")];

  factory PromptsViewModel(String promptText) {
    final PromptsViewModel model = PromptsViewModel._initialize(promptText);
    return model;
  }

  PromptsViewModel._initialize(this._promptText) {
    generateContent();
  }

  Future<void> generateContent() async {
    var err = await runBusyFuture(geminiModelService.generateContent(_content));

    if (err != null) {
      toastService.showSnackBar(message: err);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}

// TODO: notes on polymorphically changing dispose and notifyListeners when a really long asynchronous operation is running and the user navigates away from the view being loaded

