// ignore_for_file: prefer_final_fields

// TODO: Fix initally showing all mood entries

import 'package:collection/collection.dart';
import 'package:journal_app/features/analytics/models/weighted_mood.dart';
import 'package:journal_app/features/shared/abstractions/mood_mixin.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class AnalyticsViewModel extends BaseViewModel with MoodMixin {
  double _maxX = 30;

  bool _isMonthlyView = true;

  int _touchedIndex = -1;

  // List<WeightedMood> _weightedMoods = moodsService.weightedMoodData;

  List<WeightedMood> _weightedMoods = [
    for (JournalEntry entry in journalEntryServiceV2.journalEntries)
      WeightedMood(
        mood: entry.moodType,
        createdAt: entry.createdAt,
      ),
  ];

  double get maxX => _maxX;

  List<WeightedMood> get weightedMoods => _weightedMoods;

  bool get isMonthlyView => _isMonthlyView;

  int get touchedIndex => _touchedIndex;

  Map get _groupByCreatedAt => groupBy(
        [for (WeightedMood mood in _weightedMoods) mood.toMap()],
        (Map<String, dynamic> moodMap) => (moodMap['createdAt']),
      );

  List<Map> get groupedMoodsData => [for (var moodMap in _groupByCreatedAt.entries) _getMoodMetric(moodMap)]
      .sorted((moodA, moodB) => moodA.entries.toList()[0].key.compareTo(moodB.entries.toList()[0].key));

  int get totalMoodCount => (awesomeCount + happyCount + okayCount + badCount + terribleCount);

  AnalyticsViewModel();

  void setTouchedIndex(int index) {
    _touchedIndex = index;
    notifyListeners();
  }

  void filterMoodsData(MoodFilter filterBy) {
    switch (filterBy) {
      case MoodFilter.week:
        _maxX = 7;
        _isMonthlyView = false;
        _weightedMoods = [
          for (JournalEntry entry in journalEntryServiceV2.journalEntries)
            WeightedMood(
              mood: entry.moodType,
              createdAt: entry.createdAt,
            ),
        ].where((mood) => (mood.createdAt.difference(DateTime.now()).inDays).abs() <= 7).toList();
        notifyListeners();
        break;

      case MoodFilter.month:
        _maxX = 30;
        _isMonthlyView = true;
        _weightedMoods = [
          for (JournalEntry entry in journalEntryServiceV2.journalEntries)
            WeightedMood(
              mood: entry.moodType,
              createdAt: entry.createdAt,
            ),
        ].where((mood) => (mood.createdAt.difference(DateTime.now()).inDays).abs() <= 31).toList();
        notifyListeners();
        break;
    }
  }

  static Map _getMoodMetric(MapEntry moodMap) {
    double value = 0;
    int count = 0;
    for (Map<String, dynamic> moodMap in moodMap.value) {
      value += moodMap["weight"];
      count++;
    }
    return {moodMap.key: double.parse((value / count).toStringAsPrecision(2))};
  }

  @override
  int getMoodCountByMoodType(String moodType) {
    return weightedMoods.where((mood) => mood.mood == moodType).length;
  }
}

enum MoodFilter {
  week,
  month,
}
