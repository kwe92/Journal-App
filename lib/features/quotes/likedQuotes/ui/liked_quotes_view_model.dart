import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesViewModel extends ReactiveViewModel {
  List<Quote> get likedQuotes => likedQuotesService.likedQuotes;

  @override
  List<ListenableServiceMixin> get listenableServices => [likedQuotesService];

  Future<void> removeLikedQuote(Quote quote) async {
    // set liked to false
    quote.isLiked = !quote.isLiked;

    // remove quote from list of liked quotes
    likedQuotes.remove(quote);

    // delete the quote from the backend
    final response = await runBusyFuture(likedQuotesService.deleteLikedQuote(quote.id!));

    // check response status code
    final statusOK = ResponseHandler.checkStatusCode(response);

    // display error is status code is other than OK
    if (!statusOK) {
      final err = ResponseHandler.getErrorMsg(response.body);

      toastService.showSnackBar(message: err);
    } else {
      debugPrint("quote deleted successfully");
    }

    notifyListeners();
  }

  Future<void> initialize() async {
    final response = await runBusyFuture(likedQuotesService.getAllQuotes());

    final statusOK = ResponseHandler.checkStatusCode(response);

    if (!statusOK) {
      final err = ResponseHandler.getErrorMsg(response.body);

      debugPrint("error in LikedQuotesViewModel initialize method: $err");

      toastService.showSnackBar(message: err);
    }
  }
}
