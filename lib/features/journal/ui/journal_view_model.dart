import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

// TODO: implement getAllEntries method

class JournalViewModel extends BaseViewModel {
  List<JournalEntry> _journalEntries = [];

  List<JournalEntry> get journalEntries => _journalEntries;

  Future<void> initialize() async {
    setBusy(true);

    // TODO: remove Future.delayed | placed here for testing loading indicator
    // await Future.delayed(const Duration(seconds: 1));

    await journalEntryService.getAllEntries();

    // initialize journalEntries with journalEntryService.journalEntries after backend call
    _journalEntries = journalEntryService.journalEntries;

    setBusy(false);
  }

  /// Filter journal entries by mood type.
  void setFilteredJournalEntries(String mood) {
    switch (mood) {
      case 'all':
        _journalEntries = journalEntryService.journalEntries;
        notifyListeners();
        break;

      case MoodType.awesome:
        _journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.awesome).toList();
        notifyListeners();
        break;

      case MoodType.happy:
        _journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.happy).toList();
        notifyListeners();
        break;

      case MoodType.okay:
        _journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.okay).toList();
        notifyListeners();
        break;

      case MoodType.bad:
        _journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.bad).toList();
        notifyListeners();
        break;

      case MoodType.terrible:
        _journalEntries = journalEntryService.journalEntries.where((entry) => entry.moodType == MoodType.terrible).toList();
        notifyListeners();
        break;
    }
  }

  Mood getMood(JournalEntry journalEntry) {
    final MapEntry<String, MoodRecord> moodMap = MoodsData.getMoodDataByType(journalEntry.moodType);

    final Mood mood = Mood(
      moodColor: moodMap.value.color,
      moodImagePath: moodMap.value.imagePath,
      imageSize: 20,
      moodText: journalEntry.moodType,
    );

    return mood;
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
