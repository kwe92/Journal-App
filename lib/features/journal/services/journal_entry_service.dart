import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/shared/models/entry.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// Entries: type alias for List of Entry.
typedef Entries = List<Entry>;

/// JournalEntryService: retrieves all entries for the currently logged in user based on their access token.
class JournalEntryService extends ApiService with ChangeNotifier {
  Entries journalEntries = [];

  Future<void> getAllEntries() async {
    // get jwt access token saved in persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    // retrieve all entries based on access token
    final http.Response response = await get(Endpoint.entries.path, extraHeaders: {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });

    // deserialize response body `string representation of json` into List or hashMap depends on how backend sends response
    final Map<String, dynamic> reponseBody = jsonDecode(response.body);

    final List<dynamic> responseData = reponseBody["data"];

    journalEntries = responseData.map((entry) => Entry.fromJSON(entry)).toList();

    notifyListeners();
  }
}
