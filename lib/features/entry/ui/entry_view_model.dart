import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/entry/models/updated_entry.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class EntryviewModel extends ReactiveViewModel {
  final TextEditingController entryController = TextEditingController();

  final FocusNode entryFocus = FocusNode();

  final JournalEntry entry;

  String? _content;

  Color? _moodColor;

  bool _readOnly = true;

  String? get content => _content;

  bool get isIdenticalContent => content == entry.content.trim();

  bool get readOnly => _readOnly;

  int get continentalTime {
    return int.parse(timeService.getContinentalTime(entry.updatedAt.toLocal()));
  }

  String get dayOfWeekByName => timeService.dayOfWeekByName(entry.updatedAt.toLocal());

  String get timeOfDay => timeService.timeOfDay(entry.updatedAt.toLocal());

  Color? get moodColor => _moodColor;

  User? get _currentUser => userService.currentUser;

  User? get currentUser => _currentUser;

  EntryviewModel({required this.entry});

// required override for ReactiveViewModel to react to changes in a service
  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
      ];

  void initialize() {
    setContent(entry.content);
    entryController.text = _content!;
    MapEntry<String, MoodRecord> moodData = moodService.getMoodByType(entry.moodType);
    _moodColor = moodData.value.color;
  }

  void setContent(String text) {
    _content = text.trim();
    notifyListeners();
  }

  void clearContent() {
    _content = null;
    notifyListeners();
  }

  void setReadOnly(bool isReadOnly) {
    _readOnly = isReadOnly;
    notifyListeners();
  }

  /// update journal entry via API call to backend
  Future<bool> updateEntry() async {
    final UpdatedEntry updatedEntry = UpdatedEntry(
      entryId: entry.entryId,
      content: content,
    );
    setBusy(true);
    final Response response = await journalEntryService.updateEntry(updatedEntry);
    setBusy(false);
    // check status code and display a snack bar on success
    return ResponseHandler.checkStatusCode(response, "Updated journal entry successfully.");
  }

  /// delete journal entry via API call to backend
  Future<bool> deleteEntry(int entryId) async {
    setBusy(true);
    final Response response = await journalEntryService.deleteEntry(entryId);
    setBusy(false);

    // check status code and display a snack bar on success
    return ResponseHandler.checkStatusCode(response, "Deleted journal entry successfully.");
  }

  /// popup menu warning the user of permanent entry deletion
  Future<bool> continueDelete(BuildContext context, Color color) async {
    return await toastService.popupMenu<bool>(
      context,
      color: color,
      parameters: const PopupMenuParameters(
        title: "Delete Entry",
        content: "Are you sure you want to delete this entry?",
        defaultResult: false,
        options: {
          "Delete Entry": true,
          "Cancel": false,
        },
      ),
    );
  }
}

// DateTime.toLocal()

//   - Return DateTime value in the local timezone of the user
//   - should use to ensure the value matches what the back end sends

