import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/photo.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// Responsible for providing all C.R.U.D operations associated with journal entries.

class JournalEntryProvider {
  JournalEntryProvider._();

  static Future<List<JournalEntry>> getAll() async {
    final result = await databaseService.db.query(databaseService.table.entires);

    final entries = [for (Map<String, dynamic> map in result) JournalEntry.fromJSON(map)];

    final imageResult = await databaseService.db.query(databaseService.table.images);

    final images = [for (Map<String, dynamic> image in imageResult) Photo.fromJSON(image)];

    final groupedImages = groupBy(images, (image) => image.entryID);

    groupedImages.forEach((entryID, images) {
      for (var entry in entries) {
        entry.entryID == entryID ? entry.images = images : null;
      }
    });

    return entries;
  }

  static Future<int> insert(JournalEntry entry) async {
    final int entryID = await databaseService.db.insert(databaseService.table.entires, entry.toJSON());

    return entryID;
  }

  static Future<void> update(JournalEntry entry) async {
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
