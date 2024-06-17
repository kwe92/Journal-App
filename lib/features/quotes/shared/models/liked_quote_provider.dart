import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// Responsible for providing all C.R.U.D operations associated with Liked Quotes.
class LikedQuoteProvider {
  static Future<List<LikedQuote>> getAll() async {
    final List<Map<String, dynamic>> result = await databaseService.db.query(databaseService.table.likedQuotes);

    debugPrint("result: $result");

    final List<LikedQuote> quotes = [for (Map<String, dynamic> map in result) LikedQuote.fromJSON(map)];

    return quotes;
  }

  static Future<int> insert(LikedQuote quote) async {
    final int quoteID = await databaseService.db.insert(databaseService.table.likedQuotes, quote.toJSON());

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

    debugPrint('entquotery: ${quote.id} deleted successfully from the database.');
  }
}

// class LikedQuoteProvider {
//   LikedQuoteProvider._();

//   static Future<List<LikedQuote>> getAll() async {
//     final List<Map<String, dynamic>> result = await databaseService.db.query(databaseService.table.likedQuotes);

//     debugPrint("result: $result");

//     final List<LikedQuote> quotes = [for (Map<String, dynamic> map in result) LikedQuote.fromJSON(map)];

//     return quotes;
//   }

//   static Future<int> insert(LikedQuote quote) async {
//     final int quoteID = await databaseService.db.insert(databaseService.table.likedQuotes, quote.toJSON());

//     return quoteID;
//   }

//   static Future<void> edit(LikedQuote quote) async {
//     await databaseService.db.update(
//       databaseService.table.likedQuotes,
//       quote.toJSON(),
//       where: 'id = ?',
//       whereArgs: [quote.id],
//     );

//     debugPrint('quote: ${quote.id} updated successfully in the database.');
//   }

//   static Future<void> delete(LikedQuote quote) async {
//     await databaseService.db.delete(
//       databaseService.table.likedQuotes,
//       where: 'id = ?',
//       whereArgs: [quote.id],
//     );

//     debugPrint('entquotery: ${quote.id} deleted successfully from the database.');
//   }
// }
