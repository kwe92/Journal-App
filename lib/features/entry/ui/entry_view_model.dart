import 'package:http/http.dart';
import 'package:journal_app/features/entry/models/updated_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class EntryviewModel extends BaseViewModel {
  String? content;
  bool readOnly = true;

  void setContent(String text) {
    content = text;
    notifyListeners();
  }

  void clearContent() {
    content = null;
    notifyListeners();
  }

  void setReadOnly(bool isReadOnly) {
    readOnly = isReadOnly;
    notifyListeners();
  }

  Future<Response> updateEntry(UpdatedEntry updatedEntry) async {
    setBusy(true);
    final Response response = await journalEntryService.updateEntry(updatedEntry);
    setBusy(false);
    return response;
  }

  Future<Response> deleteEntry(int entryId) async {
    setBusy(true);
    final Response response = await journalEntryService.deleteEntry(entryId);
    setBusy(false);
    return response;
  }
}
