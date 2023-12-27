// ignore_for_file: unused_catch_stack

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class JournalViewModel extends ReactiveViewModel {
  List<JournalEntry> _journalEntries = [];

  List<JournalEntry> get journalEntries => _journalEntries;

  int get awesomeCount {
    return _getMoodCountByMoodType(MoodType.awesome);
  }

  int get happyCount {
    return _getMoodCountByMoodType(MoodType.happy);
  }

  int get okayCount {
    return _getMoodCountByMoodType(MoodType.okay);
  }

  int get badCount {
    return _getMoodCountByMoodType(MoodType.bad);
  }

  int get terribleCount {
    return _getMoodCountByMoodType(MoodType.terrible);
  }

  User? get _currentUser => userService.currentUser;

  User? get currentUser => _currentUser;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
        journalEntryService,
      ];

  Future<void> initialize() async {
    setBusy(true);

    // TODO: remove Future.delayed | placed here for testing loading indicator
    await Future.delayed(const Duration(seconds: 1));

    await journalEntryService.getAllEntries();

    // initialize journalEntries with journalEntryService.journalEntries after backend call

    _journalEntries = journalEntryService.journalEntries;

    setBusy(false);
  }

  Future<void> refresh() async {
    setBusy(true);
    await journalEntryService.getAllEntries();
    setBusy(false);
  }

  // retrieve all journal entries for the currently authenticated user
  Future<void> getAllEntries() async {
    final Response response = await journalEntryService.getAllEntries();

    final bool ok = ResponseHandler.checkStatusCode(response);

    if (ok) {
      // deserialize response body `string representation of json` into List or hashMap, depends on how backend sends response
      final Map<String, dynamic> reponseBody = jsonDecode(response.body);

      try {
        final List<dynamic>? responseData = reponseBody["data"];
        if (responseData != null) return;
      } catch (error, stackTrace) {
        debugPrint("error in JournalViewModel getAllEntries: ${error.toString()}");
        toastService.showSnackBar(message: "An error occured retrieving your data.", textColor: Colors.red);
      }
    }
  }

  // create Mood instance by mood type
  Mood getMood(String moodType) {
    final MapEntry<String, MoodRecord> moodMap = moodService.getMoodByType(moodType);

    final Mood mood = Mood(
      moodColor: moodMap.value.color,
      moodImagePath: moodMap.value.imagePath,
      imageSize: 20,
      moodText: moodType,
    );

    return mood;
  }

  /// filter journal entries by mood type.
  void setFilteredJournalEntries(String mood) {
    switch (mood) {
      case 'all':
        _journalEntries = journalEntryService.journalEntries;
        notifyListeners();
        break;

      case MoodType.awesome:
        _journalEntries = _fiterJournalEntries(MoodType.awesome);
        notifyListeners();
        break;

      case MoodType.happy:
        _journalEntries = _fiterJournalEntries(MoodType.happy);
        notifyListeners();
        break;

      case MoodType.okay:
        _journalEntries = _fiterJournalEntries(MoodType.okay);
        notifyListeners();
        break;

      case MoodType.bad:
        _journalEntries = _fiterJournalEntries(MoodType.bad);
        notifyListeners();
        break;

      case MoodType.terrible:
        _journalEntries = _fiterJournalEntries(MoodType.terrible);
        notifyListeners();
        break;
    }
  }

  int _getMoodCountByMoodType(String moodType) {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == moodType).length;
  }

  List<JournalEntry> _fiterJournalEntries(String moodType) {
    return journalEntryService.journalEntries.where((entry) => entry.moodType == moodType).toList();
  }
}
