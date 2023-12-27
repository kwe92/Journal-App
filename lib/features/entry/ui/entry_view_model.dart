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
  TextEditingController entryController = TextEditingController();

  FocusNode entryFocus = FocusNode();

  String? _content;

  Color? _moodColor;

  bool _readOnly = true;

  String? get content => _content;

  bool get readOnly => _readOnly;

  Color? get moodColor => _moodColor;

  User? get _currentUser => userService.currentUser;

  User? get currentUser => _currentUser;

// required override for ReactiveViewModel to react to changes in a service
  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
      ];

  void initialize(JournalEntry entry) {
    setBusy(true);
    setContent(entry.content);
    entryController.text = _content!;
    MapEntry<String, MoodRecord> moodData = moodService.getMoodByType(entry.moodType);
    _moodColor = moodData.value.color;
    setBusy(false);
  }

  void setContent(String text) {
    _content = text;
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
  Future<bool> updateEntry(UpdatedEntry updatedEntry) async {
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
