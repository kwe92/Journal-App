import 'dart:async';

import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesViewModel extends ReactiveViewModel {
  List<LikedQuote> _likedQuotes = [];

  List<LikedQuote> get likedQuotes => _likedQuotes;

  void initialize() {
    _likedQuotes = likedQuotesService.sortedLikedQuotes;
  }

  var modelQuery = ValueNotifier<String>(QuoteAuthorFilterOptions.all.name);

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    // set liked to false
    quote.isLiked = !quote.isLiked;

    await likedQuotesService.deleteLikedQuote(quote);

    var numberOfQuotes =
        likedQuotes.where((likedQuote) => likedQuote.author.trim().toLowerCase() == quote.author.trim().toLowerCase()).length;

    if (numberOfQuotes == 1) {
      final query = QuoteAuthorFilterOptions.all.name;

      modelQuery.value = query;

      setFilteredLikedQuotes(modelQuery.value);

      return;
    }

    setFilteredLikedQuotes(modelQuery.value);
  }

  void setFilteredLikedQuotes(String query) {
    modelQuery.value = query;

    if (query == QuoteAuthorFilterOptions.all.name) {
      _likedQuotes = likedQuotesService.likedQuotes;
      notifyListeners();

      return;
    }
    _likedQuotes =
        likedQuotesService.likedQuotes.where((quote) => quote.author.trim().toLowerCase() == query.trim().toLowerCase()).toList();
    notifyListeners();
  }
}
