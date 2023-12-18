import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/entry/models/updated_entry.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/services.dart';

const String _bearer = "Bearer";

/// Entries: type alias for List of Entry.
typedef JournalEntries = List<JournalEntry>;

/// JournalEntryService: entry API calls for the currently logged in user based on their access token.
class JournalEntryService extends ApiService with ChangeNotifier {
  JournalEntries journalEntries = [];

  Future<http.Response> getAllEntries() async {
    // get jwt access token saved in persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    // retrieve all entries based on access token
    final http.Response response = await get(Endpoint.entries.path, extraHeaders: {
      HttpHeaders.authorizationHeader: "$_bearer $accessToken",
    });

    // deserialize response body `string representation of json` into List or hashMap, depends on how backend sends response
    final Map<String, dynamic> reponseBody = jsonDecode(response.body);

    final List<dynamic>? responseData = reponseBody["data"];

    if (responseData != null) {
      journalEntries = responseData.map((entry) => JournalEntry.fromJSON(entry)).toList().sortedBy((entry) => entry.updatedAt);
    } else {
      journalEntries = [];
    }

    notifyListeners();

    return response;
  }

  Future<http.Response> addEntry(NewEntry newEntry) async {
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await post(
      Endpoint.entries.path,
      extraHeaders: {
        HttpHeaders.authorizationHeader: "$_bearer $accessToken",
      },
      body:
          // serialize object into JSON string
          jsonEncode(newEntry.toJSON()),
    );

    return response;
  }

  Future<http.Response> updateEntry(UpdatedEntry updatedEntry) async {
    final accessToken = await tokenService.getAccessTokenFromStorage();
    final http.Response response = await post(
      "${Endpoint.updateEntry.path}${updatedEntry.entryId}",
      extraHeaders: {
        HttpHeaders.authorizationHeader: "$_bearer $accessToken",
      },
      body:
          // serialize object into JSON string
          jsonEncode(updatedEntry.toJSON()),
    );

    return response;
  }

  Future<http.Response> deleteEntry(int entryId) async {
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await delete("${Endpoint.deleteEntry.path}$entryId", extraHeaders: {
      HttpHeaders.authorizationHeader: "$_bearer $accessToken",
    });

    return response;
  }
}
