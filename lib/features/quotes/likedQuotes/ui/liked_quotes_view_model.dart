import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/services.dart';

class LikedQuotesViewModel extends ChangeNotifier {
  List<Quote> get likedQuotes => zenQuotesApiService.quotes.where((quote) => quote.isLiked == true).toList();

  void setLikedForQuote(Quote quote) {
    quote.isLiked = !quote.isLiked;
    notifyListeners();
  }
}
