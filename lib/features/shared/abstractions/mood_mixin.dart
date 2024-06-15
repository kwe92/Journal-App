import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/services/services.dart';

// could move more duplicated code from  JournalViewModel and CalendarViewModel to here

abstract mixin class MoodMixin {
  late String query;

  int get awesomeCount {
    return getMoodCountByMoodType(MoodType.awesome.text);
  }

  int get happyCount {
    return getMoodCountByMoodType(MoodType.happy.text);
  }

  int get okayCount {
    return getMoodCountByMoodType(MoodType.okay.text);
  }

  int get badCount {
    return getMoodCountByMoodType(MoodType.bad.text);
  }

  int get terribleCount {
    return getMoodCountByMoodType(MoodType.terrible.text);
  }

  void setFilteredJournalEntries(String m, String q) {}

  int getMoodCountByMoodType(String moodType);

  /// Create [Mood] instance by mood type.
  Mood createMood(String moodType, double? imageSize) {
    final Mood mood = moodService.createMoodByType(moodType, imageSize);

    return mood;
  }
}
