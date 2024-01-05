import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:mockito/mockito.dart';

// What does Arrange, Act and Assert mean?

// Arrange (setup)

//   - the setup part of a test
//   - create an instance of the class you want to test
//   - instantiate any required dependancies the class you are testing needs

// Act (execute)

//   - after setup (Arrangement) you then execute
//     the methods or properties you want to test

// Assert (check results)

//   - after executing the method or property you want to test
//     verify that the method or property had the correct behavior
//   - this is done by assert methods of your testing framework
//     comparing actual results with expected results
//   - if the actual results match the expected results the test passes
//   - if the actual results do not match the expected results the test fails

import '../../../support/test_helpers.dart';

final JournalEntry entry = JournalEntry(
  entryId: 1,
  uid: 1,
  content: 'begin, to begin is half the work let half still remain, again begin this and thou wilt have finished.',
  moodType: 'Okay',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

// final List<JournalEntry> initialEntries = [
//   entry,
//   JournalEntry(
//     entryId: 1,
//     uid: 1,
//     content: 'begin, to begin is half the work let half still remain, again begin this and thou wilt have finished.',
//     moodType: MoodType.awesome,
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   ),
//   JournalEntry(
//     entryId: 1,
//     uid: 1,
//     content: ,
//     moodType: MoodType.happy,
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   ),
//   JournalEntry(
//     entryId: 1,
//     uid: 1,
//     content: ,
//     moodType: MoodType.okay,
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   ),
// ];

// TODO: Write Comments

void main() {
  JournalViewModel getModel() => JournalViewModel();

  group('JournalViewModelTest - Setup', () {
    setUpAll(
      () async {
        await registerSharedServices();
        when(
          locator.get<Client>().get(
                Uri.parse(testHost + Endpoint.entries.path),
                headers: anyNamed('headers'),
              ),
        ).thenAnswer(
          (_) async => Response(('[${jsonEncode(entry.toJSON())}]'), 200),
        );
      },
    );

    test('when model is first created, journal entry list is empty', () async {
      // Arrange - Setup
      final JournalViewModel model = getModel();

      // Act
      await model.initialize();

      // Assert - Result
      var actual = model.journalEntries;

      var expected = [];

      expect(actual, expected);
    });

    test('when model is created and journal entries have been loaded, journal entry list is not empty', () async {
      // Arrange - Setup
      final JournalViewModel model = getModel();

      getAndRegisterJournalEntryServiceMock(initialEntries: [entry]);

      // Act
      await model.initialize();

      // Assert - Result
      var actual = model.journalEntries;

      var expected = [entry];

      expect(actual, expected);
    });
  });

  group('JournalViewModelTest - General', () {
    setUpAll(
      () async {
        await registerSharedServices();
        when(
          locator.get<Client>().get(
                Uri.parse(testHost + Endpoint.entries.path),
                headers: anyNamed('headers'),
              ),
        ).thenAnswer(
          (_) async => Response(('[${jsonEncode(entry.toJSON())}]'), 200),
        );
      },
    );

    // TODO: continue implementation

    test('when model created and journal entries loaded, getter methods return correct count by mood', () async {
      // Arrange - Setup

      final JournalViewModel model = getModel();

      // Act

      // Assert - Result
    });
  });
}
