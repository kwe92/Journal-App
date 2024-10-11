import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesViewModel extends ReactiveViewModel {
  List<LikedQuote> get likedQuotes => likedQuotesService.sortedLikedQuotes;

  @override
  List<ListenableServiceMixin> get listenableServices => [likedQuotesService];

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    // set liked to false
    quote.isLiked = !quote.isLiked;

    await likedQuotesService.deleteLikedQuote(quote);
  }
}
