import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/services.dart';

class RandomQuotesViewModel extends ChangeNotifier {
  final pageController = PageController(viewportFraction: 1);

  List<Quote> get quotes => zenQuotesApiService.quotes;

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  RandomQuotesViewModel() {
    initialize();
  }

  void setBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }

  Future<void> initialize() async {
    setBusy(true);
    await getRandomQuotes();
    setBusy(false);

    print("\n\nQuotes from RandomQuotesViewModel: $quotes");
  }

  Future<void> getRandomQuotes() async => zenQuotesApiService.fetchRandomQuotes();

  void setLikedForQuote(Quote quote) {
    quote.isLiked = !quote.isLiked;
    notifyListeners();
  }
}
