import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/models/entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class JournalViewModel extends BaseViewModel {
  List<Entry> journalEntries = [];

  Future<void> initialize() async {
    setBusy(true);

    // TODO: remove Future.delayed | placed here for testing loading indicator
    await Future.delayed(const Duration(seconds: 1));

    await journalEntryService.getAllEntries();

    // initialize journalEntries with journalEntryService.journalEntries after backend call
    journalEntries = journalEntryService.journalEntries;

    setBusy(false);
  }

  void setFilteredJournalEntries(String mood) {
    switch (mood) {
      case 'all':
        journalEntries = journalEntryService.journalEntries;
        notifyListeners();
        break;

      case MoodType.awesome:
        journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.awesome).toList();
        notifyListeners();
        break;

      case MoodType.happy:
        journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.happy).toList();
        notifyListeners();
        break;

      case MoodType.okay:
        journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.okay).toList();
        notifyListeners();
        break;

      case MoodType.bad:
        journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.bad).toList();
        notifyListeners();
        break;

      case MoodType.terrible:
        journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.terrible).toList();
        notifyListeners();
        break;
    }
  }

  Future<void> refresh() async {
    setBusy(true);
    await journalEntryService.getAllEntries();
    setBusy(false);
  }

  int get awesomeCount {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.awesome).length;
  }

  int get happyCount {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.happy).length;
  }

  int get okayCount {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.okay).length;
  }

  int get badCount {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.bad).length;
  }

  int get terribleCount {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.terrible).length;
  }
}
