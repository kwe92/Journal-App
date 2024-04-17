import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// Responsible for providing all C.R.U.D operations associated with journal entries.

class JournalEntryProvider {
  JournalEntryProvider._();

  static Future<List<JournalEntry>> getAll() async {
    final List<Map<String, dynamic>> result = await databaseService.db.query(databaseService.table.entires);

    final List<JournalEntry> entries = [for (Map<String, dynamic> map in result) JournalEntry.fromJSON(map)];

    return entries;
  }

  static Future<int> insert(JournalEntry entry) async {
    final int entryID = await databaseService.db.insert(databaseService.table.entires, entry.toJSON());

    return entryID;
  }

  static Future<void> edit(JournalEntry entry) async {
    await databaseService.db.update(
      databaseService.table.entires,
      entry.toJSON(),
      where: 'id = ?',
      whereArgs: [entry.entryID],
    );

    debugPrint('entry: ${entry.entryID} updated successfully in the database.');
  }

  static Future<void> delete(JournalEntry entry) async {
    await databaseService.db.delete(
      databaseService.table.entires,
      where: 'id = ?',
      whereArgs: [entry.entryID],
    );

    debugPrint('entry: ${entry.entryID} deleted successfully from the database.');
  }
}
