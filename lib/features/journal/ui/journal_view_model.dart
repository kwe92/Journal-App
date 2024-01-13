// ignore_for_file: unused_catch_stack

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/resource_clean_up.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class JournalViewModel extends ReactiveViewModel {
  List<JournalEntry> _journalEntries = [];

  List<JournalEntry> get journalEntries => _journalEntries;

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

  //TODO: why is getAllEntries implemented? where is it being used?

  /// Retrieve all journal entries for the currently authenticated user.
  Future<void> getAllEntries() async {
    final Response response = await journalEntryService.getAllEntries();

    final bool statusOk = ResponseHandler.checkStatusCode(response);

    if (statusOk) {
      final Map<String, dynamic> reponseBody = jsonDecode(response.body);

      try {
        final List<dynamic>? responseData = reponseBody["data"];
        if (responseData != null) return;
      } catch (error, stackTrace) {
        debugPrint("error in JournalViewModel getAllEntries: ${error.toString()}");

        toastService.showSnackBar(message: "An error occured retrieving your data.", textColor: Colors.red);
      }
      return;
    }
    toastService.showSnackBar(
      message: ResponseHandler.getErrorMsg(response.body),
      textColor: Colors.red,
    );
  }

  // TODO: should createMood be moved to factory class??

  /// Create [Mood] instance by mood type.
  Mood createMood(String moodType, double? imageSize) {
    final Mood mood = moodService.createMoodByType(moodType, imageSize);

    return mood;
  }

  Future<void> cleanResources() async {
    await ResourceCleanUp.clean();
  }

  /// Filter journal entries by mood type.
  void setFilteredJournalEntries(String moodType) {
    const all = 'all';

    switch (moodType) {
      case all:
        _journalEntries = journalEntryService.journalEntries;
        notifyListeners();
        break;

      // used StaticMoodType as I could not use the MoodType enum for some reason
      case StaticMoodType.awesome:
        _journalEntries = _fiterJournalEntries(StaticMoodType.awesome);
        notifyListeners();
        break;

      case StaticMoodType.happy:
        _journalEntries = _fiterJournalEntries(StaticMoodType.happy);
        notifyListeners();
        break;

      case StaticMoodType.okay:
        _journalEntries = _fiterJournalEntries(StaticMoodType.okay);
        notifyListeners();
        break;

      case StaticMoodType.bad:
        _journalEntries = _fiterJournalEntries(StaticMoodType.bad);
        notifyListeners();
        break;

      case StaticMoodType.terrible:
        _journalEntries = _fiterJournalEntries(StaticMoodType.terrible);
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
