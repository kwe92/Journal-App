import 'package:flutter/material.dart';
import 'package:journal_app/features/journal/ui/journal_view.dart';
import 'package:journal_app/features/meanings/deeperMeanings/ui/deeper_meanings_view.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view.dart';

class NavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<Widget> widgetOptions = <Widget>[
    const JournalView(),
    const RandomQuotesView(),
    const LikedQuotesView(),
    const DeeperMeaningsView(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;

    notifyListeners();
  }
}
