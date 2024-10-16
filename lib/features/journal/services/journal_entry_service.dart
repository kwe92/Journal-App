import 'dart:async';

import 'package:journal_app/features/shared/models/journal_entry_provider.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:stacked/stacked.dart';

/// handles all C.R.U.D API calls for journal entries based on the currently authenticated and logged in user.
class JournalEntryService extends ApiService with ListenableServiceMixin {
  var _journalEntries = <JournalEntry>[];

  List<JournalEntry> get journalEntries => _journalEntries;

  List<JournalEntry> get sortedJournalEntries => _sortEntriesByUpdatedDate();

  DateTime get maxDate => getMaxDate(_journalEntries);

  DateTime? get minDate => getMinDates(_journalEntries);

  Future<void> getAllEntries() async {
    _journalEntries = await JournalEntryProvider.getAll();

    notifyListeners();
  }

  Future<int> addEntry(JournalEntry newEntry) async {
    final entryID = await JournalEntryProvider.insert(newEntry);

    newEntry.entryID = entryID;

    _journalEntries.insert(0, newEntry);

    notifyListeners();

    return entryID;
  }

  Future<void> updateEntry(JournalEntry updatedEntry) async {
    unawaited(JournalEntryProvider.update(updatedEntry));

    _journalEntries.removeWhere((entry) => entry.entryID == updatedEntry.entryID);

    _journalEntries.insert(0, updatedEntry);

    notifyListeners();
  }

  Future<void> deleteEntry(JournalEntry entry) async {
    unawaited(JournalEntryProvider.delete(entry));

    _journalEntries.remove(entry);

    notifyListeners();
  }

  List<JournalEntry> _sortEntriesByUpdatedDate([bool asc = false]) {
    if (asc) {
      _journalEntries.sort(
        // sort by ascending udated date
        (entryA, entryB) => entryA.updatedAt.compareTo(entryB.updatedAt),
      );
      return _journalEntries;
    } else {
      _journalEntries.sort(
        // sort by decending udated date
        (entryA, entryB) => entryB.updatedAt.compareTo(entryA.updatedAt),
      );
      return _journalEntries;
    }
  }

  DateTime getMaxDate(List<JournalEntry> entries) => entries.reduce((a, b) => a.createdAt.isAfter(b.createdAt) ? a : b).createdAt;

  DateTime? getMinDates(List<JournalEntry> entries) =>
      entries.isNotEmpty ? entries.reduce((a, b) => b.createdAt.isAfter(a.createdAt) ? a : b).createdAt : DateTime.now();
}
