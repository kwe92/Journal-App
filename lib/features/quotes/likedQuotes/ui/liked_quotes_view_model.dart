import 'dart:async';

import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesViewModel extends ReactiveViewModel {
  List<LikedQuote> _likedQuotes = [];

  List<LikedQuote> get likedQuotes => _likedQuotes;

  void initialize() {
    _likedQuotes = likedQuotesService.sortedLikedQuotes;
  }

  //!! TODO: use enum instead of a string in all the palces where the word all is used to control the liked quotes filter

  var modelQuery = ValueNotifier<String>('all');

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    // set liked to false
    quote.isLiked = !quote.isLiked;

    await likedQuotesService.deleteLikedQuote(quote);

    var numberOfQuotes =
        likedQuotes.where((likedQuote) => likedQuote.author.trim().toLowerCase() == quote.author.trim().toLowerCase()).length;

    if (numberOfQuotes == 1) {
      const query = 'All';

      modelQuery.value = query;

      setFilteredLikedQuotes(modelQuery.value);

      return;
    }

    setFilteredLikedQuotes(modelQuery.value);
  }

  void setFilteredLikedQuotes(String query) {
    modelQuery.value = query;

    if (query.trim().toLowerCase() == 'all') {
      _likedQuotes = likedQuotesService.likedQuotes;
      notifyListeners();

      return;
    }
    _likedQuotes =
        likedQuotesService.likedQuotes.where((quote) => quote.author.trim().toLowerCase() == query.trim().toLowerCase()).toList();
    notifyListeners();
  }
}
