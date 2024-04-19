import 'package:collection/collection.dart';
import 'package:journal_app/features/shared/models/journal_entry_provider.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:stacked/stacked.dart';

/// Entries: type alias for List of Entry.
typedef JournalEntries = List<JournalEntry>;

/// handles all C.R.U.D API calls for journal entries based on the currently authenticated and logged in user.
class JournalEntryService extends ApiService with ListenableServiceMixin {
  DateTime get maxDate => getMaxDate(_journalEntries);

  DateTime? get minDate => getMinDates(_journalEntries);

  JournalEntries _journalEntries = [];

  JournalEntries get journalEntries => _journalEntries;

  Future<void> getAllEntries() async {
    _journalEntries = await JournalEntryProvider.getAll();

    notifyListeners();
  }

  Future<void> addEntry(JournalEntry newEntry) async {
    final entryID = await JournalEntryProvider.insert(newEntry);

    newEntry.entryID = entryID;

    _journalEntries.add(newEntry);

    notifyListeners();
  }

  // TODO: ensure proper functionality
  Future<void> updateEntry(JournalEntry updatedEntry) async {
    await JournalEntryProvider.edit(updatedEntry);

    _journalEntries.removeWhere((entry) => entry.entryID == updatedEntry.entryID);

    _journalEntries.add(updatedEntry);

    notifyListeners();
  }

  Future<void> deleteEntry(JournalEntry entry) async {
    await JournalEntryProvider.delete(entry);

    _journalEntries.remove(entry);
    notifyListeners();
  }

  List<JournalEntry> sortByUpdatedDate(List<Map<String, dynamic>> entries, [bool asc = false]) {
    if (asc) {
      return entries.map((entry) => JournalEntry.fromJSON(entry)).toList().sorted(
            // sort by decending udated date
            (entryA, entryB) => entryA.updatedAt.compareTo(entryB.updatedAt),
          );
    } else {
      return entries.map((entry) => JournalEntry.fromJSON(entry)).toList().sorted(
            // sort by decending udated date
            (entryA, entryB) => entryB.updatedAt.compareTo(entryA.updatedAt),
          );
    }
  }

  DateTime getMaxDate(List<JournalEntry> entries) => entries.reduce((a, b) => a.createdAt.isAfter(b.createdAt) ? a : b).createdAt;

  DateTime? getMinDates(List<JournalEntry> entries) =>
      entries.isNotEmpty ? entries.reduce((a, b) => b.createdAt.isAfter(a.createdAt) ? a : b).createdAt : DateTime.now();
}
