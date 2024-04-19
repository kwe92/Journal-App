import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class RandomQuotesViewModel extends BaseViewModel {
  final pageController = PageController(viewportFraction: 1);

  List<Quote> get quotes => _getQuotesThatAreNotLiked();

  RandomQuotesViewModel() {
    initialize();

    debugPrint("RandomQuotesViewModel initialized!!");
  }

  Future<void> initialize() async {
    setBusy(true);

    await likedQuotesService.getAllQuotes();

    await getRandomQuotes();

    setBusy(false);
    // await runBusyFuture(() async {

    // }());
  }

  Future<void> getRandomQuotes() async => zenQuotesApiService.fetchRandomQuotes();

  Future<void> setLikedForQuote(Quote quote) async {
    quote.isLiked = !quote.isLiked;

    notifyListeners();

    // allows user to see heart animation filled before quote is removed from the list of quotes
    await Future.delayed(const Duration(milliseconds: 250));

    zenQuotesApiService.quotes.remove(quote);

    notifyListeners();

    await addQuote(quote);
  }

  Future<void> addQuote(Quote quote) async {
    final likedQuotes = LikedQuote(
      author: quote.author,
      quote: quote.quote,
      isLiked: quote.isLiked,
      createdAt: DateTime.now(),
    );

    await likedQuotesService.addQuote(likedQuotes);
  }

  List<Quote> _getQuotesThatAreNotLiked() =>
      zenQuotesApiService.quotes.where((quote) => !_isRandomQuoteInListOfLikedQuotes(quote)).toList();

  bool _isRandomQuoteInListOfLikedQuotes(Quote quote) {
    for (var likedQuote in likedQuotesService.likedQuotes) {
      if (quote.quote.toLowerCase() == likedQuote.quote.toLowerCase()) {
        debugPrint("_isRandomQuoteInListOfLikedQuotes: found liked quote");

        return true;
      }
    }
    return false;
  }
}
