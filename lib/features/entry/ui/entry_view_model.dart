import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/entry/models/updated_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:journal_app/features/shared/utilities/response_handler.dart';
import 'package:stacked/stacked.dart';

class EntryviewModel extends BaseViewModel {
  String? content;
  bool readOnly = true;

  void setContent(String text) {
    content = text;
    notifyListeners();
  }

  void clearContent() {
    content = null;
    notifyListeners();
  }

  void setReadOnly(bool isReadOnly) {
    readOnly = isReadOnly;
    notifyListeners();
  }

  Future<bool> updateEntry(UpdatedEntry updatedEntry) async {
    setBusy(true);
    final Response response = await journalEntryService.updateEntry(updatedEntry);
    setBusy(false);

    return ResponseHandler.checkStatusCode(response, "Updated journal entry successfully.");
  }

  Future<bool> deleteEntry(int entryId) async {
    setBusy(true);
    final Response response = await journalEntryService.deleteEntry(entryId);
    setBusy(false);

    return ResponseHandler.checkStatusCode(response, "Deleted journal entry successfully.");
  }

  Future<bool> continueDelete(BuildContext context) async {
    return await toastService.popupMenu<bool>(
      context,
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
