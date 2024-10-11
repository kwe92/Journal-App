import 'dart:async';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote_provider.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesService extends ApiService with ListenableServiceMixin {
  var _likedQuotes = <LikedQuote>[];

  List<LikedQuote> get likedQuotes => _likedQuotes;

  List<LikedQuote> get sortedLikedQuotes => _sortQuotes();

  Future<void> addQuote(LikedQuote quote) async {
    final quoteID = await LikedQuoteProvider.insert(quote);

    quote.id = quoteID;

    _likedQuotes.add(quote);

    notifyListeners();
  }

  Future<void> getAllLikedQuotes() async {
    final queryResult = await LikedQuoteProvider.getAll();

    _likedQuotes = [for (var map in queryResult) LikedQuote.fromJSON(map)];

    notifyListeners();
  }

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    unawaited(LikedQuoteProvider.delete(quote));

    _likedQuotes.remove(quote);

    notifyListeners();
  }

  List<LikedQuote> _sortQuotes() {
    _likedQuotes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return _likedQuotes;
  }
}
