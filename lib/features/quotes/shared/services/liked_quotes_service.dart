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

    _sortQuotes();

    notifyListeners();
  }

  Future<void> getAllQuotes() async {
    _likedQuotes = await LikedQuoteProvider.getAll();

    _sortQuotes();

    notifyListeners();

    debugPrint("\nliked quotes: $_likedQuotes");
  }

  Future<void> deleteLikedQuote(LikedQuote quote) async {
    await LikedQuoteProvider.delete(quote);

    _likedQuotes.remove(quote);

    notifyListeners();
  }

  void _sortQuotes() => _likedQuotes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
