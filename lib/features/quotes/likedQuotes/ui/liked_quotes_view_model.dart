import 'dart:async';

import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesViewModel extends ReactiveViewModel {
  List<LikedQuote> get likedQuotes => likedQuotesService.sortedLikedQuotes;

  var modelQuery = ValueNotifier<String>('all');

  @override
  List<ListenableServiceMixin> get listenableServices => [likedQuotesService];

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    // set liked to false
    quote.isLiked = !quote.isLiked;

    await likedQuotesService.deleteLikedQuote(quote);
  }

  // void setFilteredLikedQuotes(String query) {
  //   modelQuery.value = query;

  //   if (query.trim().toLowerCase() == 'all') {
  //     likedQuotes = likedQuotesService.likedQuotes;
  //     notifyListeners();

  //     return;
  //   }
  //   likedQuotes = likedQuotesService.likedQuotes.where((quote) => quote.author.trim().toLowerCase() == query.trim().toLowerCase()).toList();
  //   notifyListeners();
  // }
}


    // var numberOfQuotes =
    //     likedQuotes.where((likedQuote) => likedQuote.author.trim().toLowerCase() == quote.author.trim().toLowerCase()).length;

    // // remove quote from list of liked quotes
    // likedQuotes.remove(quote);

    // if (numberOfQuotes == 1) {
    //   const query = 'All';

    //   modelQuery.value = query;

    //   setFilteredLikedQuotes(query);
    // }

    // notifyListeners();