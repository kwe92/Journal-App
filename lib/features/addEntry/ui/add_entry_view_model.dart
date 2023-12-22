import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class AddEntryViewModel extends BaseViewModel {
  String? content;

  Color? _moodColor;

  Color? get moodColor => _moodColor;

  // computed variable based on content state updated with change notifier
  bool get ready {
    return content != null && content!.isNotEmpty;
  }

  void initialize(String moodType) {
    setBusy(true);
    MapEntry<String, MoodRecord> moodData = moodService.getMoodByType(moodType);
    _moodColor = moodData.value.color;
    setBusy(false);
  }

  void setContent(String text) {
    content = text;
    notifyListeners();
  }

  void clearContent() {
    content = null;

    notifyListeners();
  }

  Future<bool> addEntry(NewEntry newEntry) async {
    setBusy(true);
    final Response response = await journalEntryService.addEntry(newEntry);
    setBusy(false);

    final bool ok = ResponseHandler.checkStatusCode(response, "New journal entry added.");

    if (ok) clearContent();

    return ok;
  }
}
