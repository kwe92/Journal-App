import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesFilterButtonController extends ReactiveViewModel {
  String? _dropdownValue = 'All';

  String? get dropdownValue => _dropdownValue;

  List<String> get dropdownOptions {
    final authorNames =
        // ignore: prefer_interpolation_to_compose_strings
        likedQuotesService.likedQuotes.fold<String>("", (initialValue, quote) => initialValue + quote.author + ", ").split(", ");

    authorNames.removeLast();

    //!! TODO: sort by name
    return ['All', ...authorNames.toSet()];
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [likedQuotesService];

  void setDropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}
