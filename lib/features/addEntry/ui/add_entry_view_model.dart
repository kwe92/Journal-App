import 'package:http/http.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/services/http_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class AddEntryViewModel extends BaseViewModel {
  String? content;

  // computed variable based on content state updated with change notifier
  bool get ready {
    return content != null && content!.isNotEmpty;
  }

  void setContent(String text) {
    content = text;
    notifyListeners();
  }

  void clearContent() {
    content = null;

    notifyListeners();
  }

  Future<bool> addEntry(NewEntry newEntry) async {
    setBusy(true);
    final Response response = await journalEntryService.addEntry(newEntry);
    setBusy(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      clearContent();
      toastService.showSnackBar(message: "New journal entry added.");
      return true;
    } else {
      toastService.showSnackBar(message: getErrorMsg(response.body));
      return false;
    }
  }
}
