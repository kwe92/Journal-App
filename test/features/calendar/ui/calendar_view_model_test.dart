import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/calendar/ui/calendar_view_model.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  CalendarViewModel getModel() => CalendarViewModel();

  late final DateTime focusedDay;

  setUpAll(() async {
    await registerSharedServices();
    getAndRegisterJournalEntryServiceMock(initialEntries: testEntries);
    focusedDay = DateTime.now();
  });

  group("CalendarViewModel - ", () {
    test("when model created and initialized, then selectedEvents, focusedDay, selectedDay set", () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.initialize(focusedDay);

      // Assert - Result

      expect(model.focusedDay, focusedDay);

      expect(model.selectedDay, focusedDay);

      expect(model.selectedEvents.length, 2);
    });

    test("when set methods called, then member variables are properly set", () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.initialize(focusedDay);

      model.setSelectedEvents([]);

      model.setCalendarFormat(CalendarFormat.twoWeeks);

      model.setRangeSelectionMode(RangeSelectionMode.disabled);

      model.setFocusedDay(focusedDay.add(const Duration(days: 1)));

      model.setSelectedDay(focusedDay.add(const Duration(days: 3)));

      model.setRangeStart(focusedDay);

      model.setRangeEnd(focusedDay.add(const Duration(days: 3)));

      // Assert - Result

      expect(model.selectedEvents.length, 0);
      expect(model.calendarFormat, CalendarFormat.twoWeeks);
      expect(model.rangeSelectionMode, RangeSelectionMode.disabled);
      expect(model.focusedDay, focusedDay.add(const Duration(days: 1)));
      expect(model.selectedDay, focusedDay.add(const Duration(days: 3)));
      expect(model.rangeStart, focusedDay);
      expect(model.rangeEnd, focusedDay.add(const Duration(days: 3)));
    });

    test("when getColorByMoodType called, then correct mood color is returned", () {
      // Arrange - Setup

      getAndRegisterMoodServiceMock(MoodType.happy.text, 20);

      final model = getModel();

      model.initialize(focusedDay);

      // Act

      final Color moodColor = model.getColorByMoodType(MoodType.happy.text);

      // Assert - Result

      expect(moodColor, AppColors.moodHappy);
    });

    test("When getEventsForDay called, then correct list of events are returned", () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.initialize(focusedDay);

      final List<JournalEntry> entries = model.getEventsForDay(testEntries[2].updatedAt);

      // Assert - Result

      expect(entries.length, 1);
    });

    test("When getEventsForRange called, then correct list of events are returned", () {
      // Arrange - Setup

      getAndRegisterService<TimeService>(TimeService());

      final model = getModel();

      // Act

      model.initialize(focusedDay);

      final List<JournalEntry> entries = model.getEventsForRange(testEntries[2].updatedAt, DateTime.now());

      // Assert - Result

      expect(entries.length, 3);
    });

    test("When a range of days is selected,  then a single day is selected  the correct events are returned", () {
      // Arrange - Setup

      getAndRegisterService<TimeService>(TimeService());

      final model = getModel();

      // Act

      model.initialize(focusedDay);

      model.onRangeSelected(testEntries[2].updatedAt, DateTime.now(), focusedDay);

      final actualSelectedRange = model.selectedEvents.length;

      model.onDaySelected(testEntries[0].updatedAt, DateTime.now());

      final actualSelectedDay = model.selectedEvents.length;

      // Assert - Result

      expect(actualSelectedRange, 3);

      expect(actualSelectedDay, 2);
    });

    test("when createMoodByType called, the correct mood object is returned", () {
      // Arrange - Setup

      getAndRegisterService<MoodService>(MoodService());

      final model = getModel();

      // Act

      model.initialize(focusedDay);

      final mood = model.createMoodByType(MoodType.okay.text);

      // Assert - Result

      expect(mood.moodColor, AppColors.moodOkay);
    });
  });
}
