import 'package:journal_app/features/shared/models/entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class JournalViewModel extends BaseViewModel {
  List<Entry> get journalEntries {
    return journalEntryService.journalEntries;
  }

  Future<void> initialize() async {
    setBusy(true);
    await journalEntryService.getAllEntries();
    setBusy(false);
  }

  Future<void> refresh() async {
    setBusy(true);
    await journalEntryService.getAllEntries();
    setBusy(false);
  }
}
