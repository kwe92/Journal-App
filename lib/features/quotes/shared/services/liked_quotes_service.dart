// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote_imp.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class LikedQuotesService extends ApiService with ListenableServiceMixin {
  List<Quote> _likedQuotes = [];

  List<Quote> get likedQuotes => _likedQuotes;

  Future<http.Response> addQuote(Quote quote) async {
    // retrieve jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await post(
      Endpoint.likedQuotes.path,
      extraHeaders: {
        HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
      },
      body:
          // serialize object into JSON string
          jsonEncode(quote.toJSON()),
    );

    return response;
  }

  Future<http.Response> getAllQuotes() async {
    // get jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    // retrieve all entries based on access token
    final http.Response response = await get(Endpoint.likedQuotes.path, extraHeaders: {
      HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    });

    final Map<String, dynamic> reponseBody = jsonDecode(response.body);

    final List<dynamic>? responseData = reponseBody["data"];

    if (responseData != null) {
      // down-cast deserialized dynamic array
      final List<Map<String, dynamic>> domainData = List.from(responseData);

      // debugPrint("responseData: $responseData");

      _likedQuotes = [for (var quote in domainData) LikedQuoteImp.fromJSON(quote)];

      debugPrint("\n\n\n_likedQuotes: $_likedQuotes");
    } else {
      _likedQuotes = [];
    }

    notifyListeners();

    return response;
  }

  Future<http.Response> deleteLikedQuote(int quoteId) async {
    // retrieve jwt from persistent storage
    final accessToken = await tokenService.getAccessTokenFromStorage();

    final http.Response response = await delete("${Endpoint.deleteLikedQuote.path}$quoteId", extraHeaders: {
      HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    });

    return response;
  }
}
