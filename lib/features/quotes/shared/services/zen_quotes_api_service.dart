import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/quotes/shared/models/quote_imp.dart';
import 'package:journal_app/features/shared/services/api_service.dart';

class ZenQuotesApiService extends ApiService with ChangeNotifier {
  List<Quote> quotes = [];

  @override
  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: "application/json",
      };

  @override
  String get host => "https://zenquotes.io/api";

  Future<void> fetchRandomQuotes() async {
    final response = await get(Endpoint.randomQuotes50.path);

    if (response.statusCode == 200) {
      quotes = [
        for (Map<String, dynamic> quote in jsonDecode(response.body))
          () {
            quote.addAll({"is_liked": false});
            return QuoteImp.fromJSON(quote);
          }()
      ];

      notifyListeners();
    }
  }
}

/// backend API endpoint paths.
enum Endpoint {
  randomQuotes50("/quotes");

  final String path;

  const Endpoint(this.path);
}
