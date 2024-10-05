import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote_provider.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesViewModel extends ReactiveViewModel {
  List<LikedQuote> get likedQuotes => likedQuotesService.likedQuotes;

  @override
  List<ListenableServiceMixin> get listenableServices => [likedQuotesService];

  Future<void> initialize() async => await runBusyFuture(likedQuotesService.getAllQuotes());

  Future<void> removeLikedQuote(LikedQuote quote) async {
    // set liked to false
    quote.isLiked = !quote.isLiked;

    await LikedQuoteProvider.delete(quote);

    // remove quote from list of liked quotes
    likedQuotes.remove(quote);

    notifyListeners();
  }
}
