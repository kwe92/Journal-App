import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:stacked/stacked.dart';

class JournalViewModel extends ReactiveViewModel {
  //TODO: should searchController go in viewmodel to keep View Widget const? | should be consistent throughout the app

  final searchController = TextEditingController();

  List<JournalEntry> _journalEntries = [];

  String _currentMoodTypeFilter = 'all';

  String _query = '';

  List<JournalEntry> get journalEntries => _journalEntries;

  String get currentMoodTypeFilter => _currentMoodTypeFilter;

  String get query => _query;

  int get awesomeCount {
    return _getMoodCountByMoodType(MoodType.awesome.text);
  }

  int get happyCount {
    return _getMoodCountByMoodType(MoodType.happy.text);
  }

  int get okayCount {
    return _getMoodCountByMoodType(MoodType.okay.text);
  }

  int get badCount {
    return _getMoodCountByMoodType(MoodType.bad.text);
  }

  int get terribleCount {
    return _getMoodCountByMoodType(MoodType.terrible.text);
  }

  BaseUser? get currentUser => userService.currentUser;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
        journalEntryService,
      ];

  Future<void> initialize() async {
    await runBusyFuture(() async {
      // TODO: remove Future.delayed | placed here for testing loading indicator
      await Future.delayed(const Duration(seconds: 1));

      await journalEntryService.getAllEntries();
    }());

    _journalEntries = journalEntryService.journalEntries;
  }

  void onQueryItems(String query) {
    _setQuery(query);
    setFilteredJournalEntries(currentMoodTypeFilter, query);
    notifyListeners();
  }

  void clearQueryFromFilteredEntries() {
    _clearQuery();

    if (currentMoodTypeFilter == 'all') {
      _journalEntries = journalEntryService.journalEntries;
      notifyListeners();
      return;
    }

    _journalEntries = _fiterJournalEntries(currentMoodTypeFilter, '');

    notifyListeners();
  }

  /// Create [Mood] instance by mood type.
  Mood createMood(String moodType, double? imageSize) {
    final Mood mood = moodService.createMoodByType(moodType, imageSize);

    return mood;
  }

  Future<void> cleanResources() async {
    await ResourceCleanUp.clean();
  }

  /// Filter journal entries by mood type and query.
  void setFilteredJournalEntries(String moodType, String query) {
    const all = 'all';

    switch (moodType) {
      case all:
        _setCurrentMoodTypeFilter(all);
        _journalEntries =
            journalEntryService.journalEntries.where((entry) => entry.content.toLowerCase().contains(query.toLowerCase())).toList();
        notifyListeners();
        break;

      // used StaticMoodType as I could not use the MoodType enum for some reason
      case StaticMoodType.awesome:
        _setCurrentMoodTypeFilter(StaticMoodType.awesome);

        _journalEntries = _fiterJournalEntries(StaticMoodType.awesome, query);

        notifyListeners();

        break;

      case StaticMoodType.happy:
        _setCurrentMoodTypeFilter(StaticMoodType.happy);

        _journalEntries = _fiterJournalEntries(StaticMoodType.happy, query);

        notifyListeners();

        break;

      case StaticMoodType.okay:
        _setCurrentMoodTypeFilter(StaticMoodType.okay);

        _journalEntries = _fiterJournalEntries(StaticMoodType.okay, query);

        notifyListeners();

        break;

      case StaticMoodType.bad:
        _setCurrentMoodTypeFilter(StaticMoodType.bad);

        _journalEntries = _fiterJournalEntries(StaticMoodType.bad, query);

        notifyListeners();

        break;

      case StaticMoodType.terrible:
        _setCurrentMoodTypeFilter(StaticMoodType.terrible);

        _journalEntries = _fiterJournalEntries(StaticMoodType.terrible, query);

        notifyListeners();

        break;
    }
  }

  void _setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void _clearQuery() {
    _query = '';
    notifyListeners();
  }

  void _setCurrentMoodTypeFilter(String moodType) {
    _currentMoodTypeFilter = moodType;
    notifyListeners();
  }

  int _getMoodCountByMoodType(String moodType) {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == moodType).length;
  }

  List<JournalEntry> _fiterJournalEntries(String moodType, String query) {
    return journalEntryService.journalEntries
        .where((entry) => entry.moodType == moodType && entry.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

// //TODO: why is getAllEntries implemented? where is it being used?

//   /// Retrieve all journal entries for the currently authenticated user.
//   Future<void> getAllEntries() async {
//     final Response response = await journalEntryService.getAllEntries();

//     final bool statusOk = ResponseHandler.checkStatusCode(response);

//     if (statusOk) {
//       final Map<String, dynamic> reponseBody = jsonDecode(response.body);

//       try {
//         final List<dynamic>? responseData = reponseBody["data"];
//         if (responseData != null) return;
//       } catch (error, stackTrace) {
//         debugPrint("error in JournalViewModel getAllEntries: ${error.toString()}");

//         toastService.showSnackBar(message: "An error occured retrieving your data.", textColor: Colors.red);
//       }
//       return;
//     }
//     toastService.showSnackBar(
//       message: ResponseHandler.getErrorMsg(response.body),
//       textColor: Colors.red,
//     );
//   }
