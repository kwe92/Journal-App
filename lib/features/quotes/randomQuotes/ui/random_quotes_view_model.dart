import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class RandomQuotesViewModel extends BaseViewModel {
  final pageController = PageController(viewportFraction: 1);

  List<Quote> get quotes => _getQuotesThatAreNotLiked();

  RandomQuotesViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    await runBusyFuture(() async {
      await likedQuotesService.getAllQuotes();
      await getRandomQuotes();
    }());

    debugPrint("\n\nQuotes from RandomQuotesViewModel: $quotes");
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
    final response = await likedQuotesService.addQuote(quote);

    final statusOK = ResponseHandler.checkStatusCode(response);

    if (!statusOK) {
      final err = ResponseHandler.getErrorMsg(response.body);

      toastService.showSnackBar(message: err);
    } else {
      debugPrint("quote added successfully: $quote");
    }
  }
}

List<Quote> _getQuotesThatAreNotLiked() => zenQuotesApiService.quotes.where((quote) => !_isRandomQuoteInListOfLikedQuotes(quote)).toList();

bool _isRandomQuoteInListOfLikedQuotes(Quote quote) {
  for (var likedQuote in likedQuotesService.likedQuotes) {
    if (quote.quote.toLowerCase() == likedQuote.quote.toLowerCase()) {
      debugPrint("_isRandomQuoteInListOfLikedQuotes: found liked quote");

      return true;
    }
  }
  return false;
}
