import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// Responsible for providing all C.R.U.D operations associated with Liked Quotes.
class LikedQuoteProvider {
  const LikedQuoteProvider._();

  static Future<List<Map<String, Object?>>> getAll() async {
    final result = await databaseService.db.query(databaseService.table.likedQuotes);

    return result;
  }

  static Future<int> insert(LikedQuote quote) async {
    final quoteID = await databaseService.db.insert(databaseService.table.likedQuotes, quote.toJSON());
    debugPrint('likedQuotes table insert: quote with id: $quoteID inserted into database');

    return quoteID;
  }

  static Future<void> edit(LikedQuote quote) async {
    await databaseService.db.update(
      databaseService.table.likedQuotes,
      quote.toJSON(),
      where: 'id = ?',
      whereArgs: [quote.id],
    );

    debugPrint('quote: ${quote.id} updated successfully in the database.');
  }

  static Future<void> delete(LikedQuote quote) async {
    await databaseService.db.delete(
      databaseService.table.likedQuotes,
      where: 'id = ?',
      whereArgs: [quote.id],
    );

    debugPrint('likedQuotes table delete: quote with id: ${quote.id} deleted successfully from the database');
  }
}
