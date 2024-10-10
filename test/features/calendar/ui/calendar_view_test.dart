import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/calendar/ui/calendar_view.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/image_picker_service.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  setUpAll(() async => await registerSharedServices());

  group("CalendarView - ", () {
    final DateTime focusedDay = DateTime.now();

    testWidgets("when calender focused, then correct events are selected", (tester) async {
      // Arrange - Setup
      getAndRegisterJournalEntryServiceMock(initialEntries: testEntries);
      getAndRegisterService<MoodService>(MoodService());
      getAndRegisterService<TimeService>(TimeService());

      getAndRegisterService<FlutterSecureStorage>(const FlutterSecureStorage());
      getAndRegisterService<AppModeService>(AppModeService());

      getAndRegisterService<ImagePickerService>(ImagePickerService());

      appModeService.setLightMode(true);

      // Act
      await pumpView(
        tester,
        view: ChangeNotifierProvider(
          create: (context) => JournalViewModel(),
          builder: (context, child) => CalendarView(focusedDay: focusedDay),
        ),
        changeNotifierValue: appModeService,
      );

      await tester.pumpAndSettle();

      final calendarFinder = find.byType(TableCalendar<JournalEntry>);

      final journalEntryCardFinder = find.textContaining(testEntries[0].content, skipOffstage: false);

      // Assert - Result

      expect(calendarFinder, findsOneWidget);

      expect(journalEntryCardFinder, findsOneWidget);
    });

    // testWidgets("when journal entry card tapped, then navigate to entry view", (tester) async {
    //   // Arrange - Setup
    //   getAndRegisterJournalEntryServiceMock(initialEntries: testEntries);
    //   getAndRegisterService<MoodService>(MoodService());
    //   getAndRegisterService<TimeService>(TimeService());
    //   getAndRegisterService<AppRouter>(AppRouter());

    //   // Act
    //   await tester.pumpWidget(
    //     TestingWrapper(
    //       CalendarView(
    //         focusedDay: focusedDay,
    //       ),
    //     ),
    //   );

    //   await tester.pumpAndSettle();

    //   final calendarFinder = find.byType(TableCalendar<JournalEntry>);

    //   final journalEntryCardFinder = find.textContaining(testEntries[0].content, skipOffstage: false);

    //   final scaffoldFinder = find.byType(BaseScaffold);

    //   final listViewFinder = find.byType(ListView, skipOffstage: false);

    //   // Assert - Result

    //   // expect(calendarFinder, findsOneWidget);

    //   // expect(journalEntryCardFinder, findsOneWidget);

    //   expect(scaffoldFinder, findsOneWidget);

    //   expect(listViewFinder, findsOneWidget);

    //   await tester.dragUntilVisible(
    //     listViewFinder,
    //     scaffoldFinder,
    //     const Offset(0, 500),
    //   );

    //   await tester.dragUntilVisible(
    //     journalEntryCardFinder,
    //     listViewFinder,
    //     const Offset(0, 500),
    //   );

    //   // await tester.scrollUntilVisible(journalEntryCardFinder, 0, scrollable: listViewFinder);

    //   await tester.tap(journalEntryCardFinder);

    //   await tester.pumpAndSettle();
    // });
  });
}
