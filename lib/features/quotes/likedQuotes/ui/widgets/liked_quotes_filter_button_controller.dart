import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesFilterButtonController extends ReactiveViewModel {
  String? _dropdownValue = QuoteAuthorFilterOptions.all.name;

  String? get dropdownValue => _dropdownValue;

  List<String> get dropdownOptions {
    final authorNames =
        // when likedQuotesService.likedQuotes changes this getter is recomputed
        // ignore: prefer_interpolation_to_compose_strings
        likedQuotesService.likedQuotes.fold<String>("", (initialValue, quote) => initialValue + quote.author + ", ").split(", ");

    authorNames.removeLast();
    // sort in alphabetical order
    authorNames.sort((a, b) => a.compareTo(b));

    return [QuoteAuthorFilterOptions.all.name, ...authorNames.toSet()];
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [likedQuotesService];

  void setDropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}
