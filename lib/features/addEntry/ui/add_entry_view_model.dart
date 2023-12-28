import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class AddEntryViewModel extends BaseViewModel {
  String? _content;

  Color? _moodColor;

  String? get content => _content;

  Color? get moodColor => _moodColor;

  late final DateTime now;

  // computed variable based on content state updated with change notifier
  bool get ready {
    return _content != null && _content!.isNotEmpty;
  }

  int get continentalTime {
    return int.parse(timeService.getContinentalTime(now));
  }

  String get dayOfWeekByName => timeService.dayOfWeekByName(now);

  String get timeOfDay => timeService.timeOfDay(now);

  void initialize(String moodType) {
    // set the theme for the view to the color of the mood type
    MapEntry<String, MoodRecord> moodData = moodService.getMoodByType(moodType);
    _moodColor = moodData.value.color;

    now = DateTime.now();
  }

  void setContent(String text) {
    _content = text.trim();
    notifyListeners();
  }

  void clearContent() {
    _content = null;

    notifyListeners();
  }

  /// attemt to add entry to the backend
  Future<bool> addEntry(String moodType, String content) async {
    // instantiate new entry
    final NewEntry newEntry = NewEntry(content: content, moodType: moodType);

    setBusy(true);
    final Response response = await journalEntryService.addEntry(newEntry);
    setBusy(false);

    final bool ok = ResponseHandler.checkStatusCode(response);

    if (ok) {
      clearContent();
      toastService.showSnackBar(message: "New journal entry added.");

      return ok;
    }
    toastService.showSnackBar(
      message: ResponseHandler.getErrorMsg(response.body),
      textColor: Colors.red,
    );

    return ok;
  }
}
