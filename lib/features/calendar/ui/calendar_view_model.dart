// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel extends ChangeNotifier {
  late List<JournalEntry> _selectedEvents;

  List<JournalEntry> _filteredSelectedEvents = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  DateTime? _rangeStart;

  DateTime? _rangeEnd;

  // List<JournalEntry> _filteredSelectedEvents = [];

  String _currentMoodTypeFilter = MoodTypeFilterOptions.all;

  String _query = '';

  List<JournalEntry> get selectedEvents => _selectedEvents;

  CalendarFormat get calendarFormat => _calendarFormat;

  RangeSelectionMode get rangeSelectionMode => _rangeSelectionMode;

  DateTime get focusedDay => _focusedDay;

  DateTime? get selectedDay => _selectedDay;

  DateTime? get rangeStart => _rangeStart;

  DateTime? get rangeEnd => _rangeEnd;

  DateTime get minDate => journalEntryService.minDate ?? DateTime.now();

  List<JournalEntry> get filteredSelectedEvents => _filteredSelectedEvents;

  String get currentMoodTypeFilter => _currentMoodTypeFilter;

  String get query => _query;

  int get awesomeCount {
    return _getMoodCountByMoodType(MoodType.awesome.text);
  }

  int get happyCount {
    return _getMoodCountByMoodType(MoodType.happy.text);
  }

  int get okayCount {
    return _getMoodCountByMoodType(MoodType.okay.text);
  }

  int get badCount {
    return _getMoodCountByMoodType(MoodType.bad.text);
  }

  int get terribleCount {
    return _getMoodCountByMoodType(MoodType.terrible.text);
  }

  void initialize(DateTime focusedDay) {
    _focusedDay = focusedDay;

    _selectedDay = _focusedDay;

    _selectedEvents = getEventsForDay(_selectedDay!);

    _filteredSelectedEvents = _selectedEvents;

    notifyListeners();

    debugPrint("_filteredSelectedEvents:$_filteredSelectedEvents");
  }

  void setSelectedEvents(List<JournalEntry> selectedEvents) {
    _selectedEvents = selectedEvents;

    _filteredSelectedEvents = selectedEvents;

    notifyListeners();
  }

  void setCalendarFormat(CalendarFormat calendarFormat) {
    _calendarFormat = calendarFormat;
    notifyListeners();
  }

  void setRangeSelectionMode(RangeSelectionMode rangeSelectionMode) {
    _rangeSelectionMode = rangeSelectionMode;
    notifyListeners();
  }

  void setFocusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void setSelectedDay(DateTime? selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void setRangeStart(DateTime? rangeStart) {
    _rangeStart = rangeStart;
    notifyListeners();
  }

  void setRangeEnd(DateTime? rangeEnd) {
    _rangeEnd = rangeEnd;
    notifyListeners();
  }

  Color getColorByMoodType(String moodType) => moodService.getMoodColorByType(moodType);

  List<JournalEntry> getEventsForDay(DateTime day) {
    // Implementation example
    return journalEntryService.journalEntries.where((entry) => isSameDay(entry.updatedAt, day)).toList();
  }

  List<JournalEntry> getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = timeService.daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeStart = null; // Important to clean those
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;

      _selectedEvents = getEventsForDay(selectedDay);

      _filteredSelectedEvents = _selectedEvents;
    }

    notifyListeners();
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    _selectedDay = null;
    _focusedDay = focusedDay;
    _rangeStart = start;
    _rangeEnd = end;
    _rangeSelectionMode = RangeSelectionMode.toggledOn;

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents = getEventsForRange(start, end);
      _filteredSelectedEvents = _selectedEvents;
    } else if (start != null) {
      _selectedEvents = getEventsForDay(start);
      _filteredSelectedEvents = _selectedEvents;
    } else if (end != null) {
      _selectedEvents = getEventsForDay(end);
      _filteredSelectedEvents = _selectedEvents;
    }

    notifyListeners();
  }

  Mood createMoodByType(String moodType) => moodService.createMoodByType(moodType);

  /// Filter journal entries by mood type and query.
  void setFilteredJournalEntries(String moodType, String query) {
    switch (moodType) {
      case MoodTypeFilterOptions.all:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.all);
        _filteredSelectedEvents = _selectedEvents.where((entry) => entry.content.toLowerCase().contains(query.toLowerCase())).toList();
        notifyListeners();
        break;

      // used MoodTypeFilterOptions as I could not use the MoodType enum for some reason
      case MoodTypeFilterOptions.awesome:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.awesome);

        _filteredSelectedEvents = _fiterJournalEntries(MoodTypeFilterOptions.awesome, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.happy:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.happy);

        _filteredSelectedEvents = _fiterJournalEntries(MoodTypeFilterOptions.happy, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.okay:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.okay);

        _filteredSelectedEvents = _fiterJournalEntries(MoodTypeFilterOptions.okay, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.bad:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.bad);

        _filteredSelectedEvents = _fiterJournalEntries(MoodTypeFilterOptions.bad, query);

        notifyListeners();

        break;

      case MoodTypeFilterOptions.terrible:
        _setCurrentMoodTypeFilter(MoodTypeFilterOptions.terrible);

        _filteredSelectedEvents = _fiterJournalEntries(MoodTypeFilterOptions.terrible, query);

        notifyListeners();

        break;
    }
  }

  void _setCurrentMoodTypeFilter(String moodType) {
    _currentMoodTypeFilter = moodType;
    notifyListeners();
  }

  int _getMoodCountByMoodType(String moodType) {
    return _selectedEvents.where((entry) => entry.moodType == moodType).length;
  }

  List<JournalEntry> _fiterJournalEntries(String moodType, String query) {
    return _selectedEvents
        .where((entry) => entry.moodType == moodType && entry.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Create [Mood] instance by mood type.
  Mood createMood(String moodType, double? imageSize) {
    final Mood mood = moodService.createMoodByType(moodType, imageSize);

    return mood;
  }
}
