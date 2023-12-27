import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/entry/models/updated_entry.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

/// Entries: type alias for List of Entry.
typedef JournalEntries = List<JournalEntry>;

/// handles all C.R.U.D API calls for journal entries based on the currently authenticated and logged in user.
class JournalEntryService extends ApiService with ListenableServiceMixin {
  JournalEntries journalEntries = [];

  Future<http.Response> getAllEntries() async {
    // get jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    // retrieve all entries based on access token
    final http.Response response = await get(Endpoint.entries.path, extraHeaders: {
      HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    });

    // deserialize response body `string representation of json` into List or hashMap, depends on how backend sends response
    final Map<String, dynamic> reponseBody = jsonDecode(response.body);

    final List<dynamic>? responseData = reponseBody["data"];

    if (responseData != null) {
      journalEntries = responseData.map((entry) => JournalEntry.fromJSON(entry)).toList().sorted(
            // sort by decending udated date
            (entryA, entryB) => entryB.updatedAt.compareTo(entryA.updatedAt),
          );
    } else {
      journalEntries = [];
    }

    notifyListeners();

    return response;
  }

  Future<http.Response> addEntry(NewEntry newEntry) async {
    // retrieve jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await post(
      Endpoint.entries.path,
      extraHeaders: {
        HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
      },
      body:
          // serialize object into JSON string
          jsonEncode(newEntry.toJSON()),
    );

    return response;
  }

  Future<http.Response> updateEntry(UpdatedEntry updatedEntry) async {
    // retrieve jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await post(
      "${Endpoint.updateEntry.path}${updatedEntry.entryId}",
      extraHeaders: {
        HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
      },
      body:
          // serialize object into JSON string
          jsonEncode(updatedEntry.toJSON()),
    );

    return response;
  }

  Future<http.Response> deleteEntry(int entryId) async {
    // retrieve jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await delete("${Endpoint.deleteEntry.path}$entryId", extraHeaders: {
      HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    });

    return response;
  }
}
