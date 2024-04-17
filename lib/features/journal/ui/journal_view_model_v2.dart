import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/abstractions/mood_mixin.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:stacked/stacked.dart';

class JournalViewModelV2 extends ReactiveViewModel with MoodMixin {
  final searchNode = FocusNode();
  final searchController = TextEditingController();

  List<JournalEntry> _journalEntries = [];

  String _currentMoodTypeFilter = MoodTypeFilterOptions.all;

  String _query = '';

  bool _isFabVisible = true;

  List<JournalEntry> get journalEntries => _journalEntries;

  String get currentMoodTypeFilter => _currentMoodTypeFilter;

  @override
  String get query => _query;

  bool get isFabVisible => _isFabVisible;

  BaseUser? get currentUser => userService.currentUser;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
        journalEntryServiceV2,
      ];

  Future<void> initialize() async {
    await runBusyFuture(() async {
      // TODO: remove Future.delayed | placed here for testing loading indicator
      await Future.delayed(const Duration(seconds: 1));

      await journalEntryServiceV2.getAllEntries();

      debugPrint("JournalViewModelV2: initialize called");
    }());

    _journalEntries = journalEntryServiceV2.journalEntries;
  }

  void onQueryItems(String query) {
    _setQuery(query);
    setFilteredJournalEntries(currentMoodTypeFilter, query);
    notifyListeners();
  }

  void clearQueryFromFilteredEntries() {
    _clearQuery();

    if (currentMoodTypeFilter == MoodTypeFilterOptions.all) {
      _journalEntries = journalEntryServiceV2.journalEntries;
      notifyListeners();
      return;
    }

    _journalEntries = _fiterJournalEntries(currentMoodTypeFilter, '');

    notifyListeners();
  }

  setFabVisibility(bool isVisible) {
    _isFabVisible = isVisible;
    notifyListeners();
  }

  Future<void> cleanResources() async {
    await ResourceCleanUp.clean();
  }

  /// Filter journal entries by mood type and query.
  @override
  void setFilteredJournalEntries(String moodType, String query) {
    switch (moodType) {
      case MoodTypeFilterOptions.all:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.all);
        _journalEntries =
            journalEntryServiceV2.journalEntries.where((entry) => entry.content.toLowerCase().contains(query.toLowerCase())).toList();
        notifyListeners();
        break;

      // used MoodTypeFilterOptions as I could not use the MoodType enum for some reason
      case MoodTypeFilterOptions.awesome:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.awesome);

        _journalEntries = _fiterJournalEntries(MoodTypeFilterOptions.awesome, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.happy:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.happy);

        _journalEntries = _fiterJournalEntries(MoodTypeFilterOptions.happy, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.okay:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.okay);

        _journalEntries = _fiterJournalEntries(MoodTypeFilterOptions.okay, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.bad:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.bad);

        _journalEntries = _fiterJournalEntries(MoodTypeFilterOptions.bad, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.terrible:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.terrible);

        _journalEntries = _fiterJournalEntries(MoodTypeFilterOptions.terrible, query);

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

  @override
  int getMoodCountByMoodType(String moodType) {
    return journalEntryServiceV2.journalEntries.where((entry) => entry.moodType == moodType).length;
  }

  List<JournalEntry> _fiterJournalEntries(String moodType, String query) {
    return journalEntryServiceV2.journalEntries
        .where((entry) => entry.moodType == moodType && entry.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
