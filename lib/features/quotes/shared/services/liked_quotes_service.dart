// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote_provider.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesService extends ApiService with ListenableServiceMixin {
  List<LikedQuote> _likedQuotes = [];

  List<LikedQuote> get likedQuotes => _likedQuotes;

  Future<void> addQuote(LikedQuote quote) async {
    await LikedQuoteProvider.insert(quote);
    _likedQuotes.add(quote);
    notifyListeners();

    // // retrieve jwt from persistent storage
    // final accessToken = await tokenService.getAccessTokenFromStorage();

    // final http.Response response = await post(
    //   Endpoint.likedQuotes.path,
    //   extraHeaders: {
    //     HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    //   },
    //   body:
    //       // serialize object into JSON string
    //       jsonEncode(quote.toJSON()),
    // );

    // return response;
  }

  Future<void> getAllQuotes() async {
    _likedQuotes = await LikedQuoteProvider.getAll();

    notifyListeners();

    debugPrint("\n\n\n_likedQuotes: $_likedQuotes");
    // // get jwt from persistent storage
    // final accessToken = await tokenService.getAccessTokenFromStorage();

    // // retrieve all entries based on access token
    // final http.Response response = await get(Endpoint.likedQuotes.path, extraHeaders: {
    //   HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    // });

    // final Map<String, dynamic> reponseBody = jsonDecode(response.body);

    // final List<dynamic>? responseData = reponseBody["data"];

    // if (responseData != null) {
    //   // down-cast deserialized dynamic array
    //   final List<Map<String, dynamic>> domainData = List.from(responseData);

    //   // debugPrint("responseData: $responseData");

    //   _likedQuotes = [for (var quote in domainData) LikedQuoteImp.fromJSON(quote)];

    //   debugPrint("\n\n\n_likedQuotes: $_likedQuotes");
    // } else {
    //   _likedQuotes = [];
    // }

    // notifyListeners();

    // return response;
  }

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    await LikedQuoteProvider.delete(quote);
    ;
    _likedQuotes.remove(quote);

    notifyListeners();

    // // retrieve jwt from persistent storage
    // final accessToken = await tokenService.getAccessTokenFromStorage();

    // final http.Response response = await delete("${Endpoint.deleteLikedQuote.path}$quoteId", extraHeaders: {
    //   HttpHeaders.authorizationHeader: "$bearerPrefix $accessToken",
    // });

    // return response;
  }
}
