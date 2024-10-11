import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class RandomQuotesViewModel extends BaseViewModel {
  final pageController = PageController(viewportFraction: 1);

  Artboard? _riveArtBoard;

  SMITrigger? _likeTrigger;

  Artboard? get riveArtBoard => _riveArtBoard;

  SMITrigger? get likeTrigger => _likeTrigger;

  List<Quote> get quotes => _getQuotesThatAreNotLiked();

  RandomQuotesViewModel() {
    initialize();

    debugPrint("RandomQuotesViewModel initialized!!");
  }

  Future<void> initialize() async {
    try {
      setBusy(true);

      // run all futures concurrently waiting for them all to complete, the process takes as long as the longest running future
      await Future.wait([
        getRandomQuotes(),
        loadRiveHeart(),
      ], eagerError: true);

      setBusy(false);
    } catch (err, _) {
      debugPrint('ERROR - RandomQuotesViewModel.initialize:\n${err.toString()}');
      setBusy(false);
    }
  }

  Future<void> getRandomQuotes() async => zenQuotesApiService.fetchRandomQuotes();

  Future<void> setLikedForQuote(Quote quote) async {
    toogleLikeQuote();

    quote.isLiked = !quote.isLiked;

    // allows user to see heart animation before quote is removed from the list of quotes
    await Future.delayed(const Duration(milliseconds: 350));

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
        return true;
      }
    }
    return false;
  }

  void toogleLikeQuote() => _likeTrigger?.value = true;

  Future<void> loadRiveHeart() async {
    await rootBundle.load('assets/rive/animated_heart.riv').then((data) async {
      try {
        debugPrint('loading RiveHeart\n');

        // load rive file from binary data (bytes of data) retrieved from the rive animation
        final riveFile = RiveFile.import(data);

        debugPrint('riveFile: $riveFile\n');

        //  the art board is the root of the animation, extracted from the rive file
        final artBoard = riveFile.mainArtboard;

        // create state machine controller from the extracted artboard
        final controller = StateMachineController.fromArtboard(artBoard, 'favorite');

        debugPrint('controller: $controller\n');

        // add controller to the artboard
        if (controller != null) {
          debugPrint('adding state machine controller\n');

          artBoard.addController(controller);

          // find the type of action you want to perform from the StateMachineController

          //   - the action could be null and may need to be set first client side

          // Examples

          //   - shouldDance = controller.findSMI('dance');

          //   - shouldLookUp = controller.getTriggerInput('look up');

          for (var input in controller.inputs) {
            debugPrint('input name: ${input.name}');
            debugPrint('input type: ${input.runtimeType}');
            debugPrint('input value: ${input.value}\n');
          }

          _likeTrigger = controller.getTriggerInput('like');

          // update artboard variable for this widget

          debugPrint('art board: $artBoard');

          _riveArtBoard = artBoard;

          notifyListeners();
        }
      } catch (err, _) {
        debugPrint('ERROR: ${err.toString()}');
      }
    });
  }
}
