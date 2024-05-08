import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/abstractions/mood_mixin.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/photo.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:stacked/stacked.dart';

class JournalViewModel extends ReactiveViewModel with MoodMixin {
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
        journalEntryService,
      ];

  JournalViewModel() {
    initialize();
  }

  void initialize() {
    _journalEntries = journalEntryService.journalEntries;

    searchNode.addListener(() {
      searchNode.hasFocus ? setFabVisibility(false) : setFabVisibility(true);
    });
    notifyListeners();
  }

  void onQueryItems(String query) {
    _setQuery(query);
    setFilteredJournalEntries(currentMoodTypeFilter, query);
    notifyListeners();
  }

  void clearQueryFromFilteredEntries() {
    _clearQuery();

    if (currentMoodTypeFilter == MoodTypeFilterOptions.all) {
      _journalEntries = journalEntryService.journalEntries;
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

  List<ImageProvider> convertToImageProvider(List<Photo?> images) => imagePickerService.imageFromBase64String(images);

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
            journalEntryService.journalEntries.where((entry) => entry.content.toLowerCase().contains(query.toLowerCase())).toList();
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
    return journalEntryService.journalEntries.where((entry) => entry.moodType == moodType).length;
  }

  List<JournalEntry> _fiterJournalEntries(String moodType, String query) {
    return journalEntryService.journalEntries
        .where((entry) => entry.moodType == moodType && entry.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
