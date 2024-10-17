import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:mockito/mockito.dart';

//!! TODO: move to flutter widgets repo
// What does Arrange, Act and Assert mean?

// Arrange (setup)

//   - the setup part of a test

//   - create an instance of the class you want to test

//   - instantiate any required dependancies (services) the class you are testing needs

// Act (execute)

//   - after setup (Arrangement) you then execute
//     the methods or properties you want to test

// Assert (check results)

//   - after executing the method or property you want to test
//     verify that the method or property had the correct behavior

//   - this is done by the assert methods of your testing framework
//     comparing actual results with expected results

//   - if the actual results match the expected results the test passes

//   - if the actual results do not match the expected results the test fails

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  /// returns ViewModel for this test
  JournalViewModel getModel() => JournalViewModel();

  // registered setup function ran once before all tests
  setUpAll(
    () async {
      // register required depenencies
      await registerSharedServices();

      // stub api call with Client
      when(locator.get<Client>().get(
            Uri.parse(testHost + Endpoint.entries.path),
            headers: anyNamed('headers'),
          )).thenAnswer((_) async => Response(('[${jsonEncode(testEntry.toJSON())}]'), 200));
    },
  );

  group('JournalViewModelTest - Setup', () {
    test('when model is first created, journal entry list is not empty', () async {
      /// Arrange - Setup

      var model = getModel();

      getAndRegisterJournalEntryServiceMock(initialEntries: testEntries);

      /// Act

      model.initialize();

      /// Assert - Result

      // actual result
      var actual = model.journalEntries;

      // expected result
      var expected = testEntries;

      // assert and match
      expect(actual, expected);
    });

    test('when model is created and journal entries have been loaded, journal entry list is not empty', () async {
      /// Arrange - Setup

      // register with a single entry
      getAndRegisterJournalEntryServiceMock(initialEntries: [testEntry]);

      var model = getModel();

      /// Act

      model.initialize();

      /// Assert - Result

      // actual result
      var actual = model.journalEntries;

      // expected result
      var expected = [testEntry];

      // assert and match
      expect(actual, expected);

      // registered tear down function ran once after each tests
    });
    // TODO: review why tearDown is making tests fail
    // tearDown(() => unregisterServices());
  });

  group('JournalViewModelTest - General', () {
    // registered setup function ran once before all tests
    test('when model created and journal entries loaded, getter methods return correct count by mood', () async {
      /// Arrange - Setup
      getAndRegisterJournalEntryServiceMock(initialEntries: testEntries);

      var model = getModel();

      /// Act

      model.initialize();

      /// Assert - Result

      // actual result
      var actual = model.journalEntries;

      // expected result
      var expected = testEntries;

      // assert and match
      expect(actual, expected);

      // actual mood count

      var actualAwesomeCount = model.awesomeCount;

      var actualHappyCount = model.happyCount;

      var actualOkayCount = model.okayCount;

      var actualBadCount = model.badCount;

      var actualTerribleCount = model.terribleCount;

      // expected mood count

      var expectedAwesomeCount = 2;

      var expectedHappyCount = 1;

      var expectedOkayCount = 1;

      var expectedBadCount = 0;

      var expectedTerribleCount = 0;

      // assert and match

      expect(actualAwesomeCount, expectedAwesomeCount);

      expect(actualHappyCount, expectedHappyCount);

      expect(actualOkayCount, expectedOkayCount);

      expect(actualBadCount, expectedBadCount);

      expect(actualTerribleCount, expectedTerribleCount);
    });

    test('when model is created, createMood returns mood object', () {
      // Arrange - Setup

      var moodType = MoodType.okay.text;

      var imageSize = 20.0;

      getAndRegisterMoodServiceMock(moodType, imageSize);

      var model = getModel();

      // Act

      var mood = model.createMood(moodType, imageSize);

      // Assert - Result

      var actual = mood.moodText;

      var expected = MoodType.okay.text;

      expect(actual, expected);
    });

    test('when cleanResources called, resource clean up functions are executed', () async {
      // Arrange - Setup

      var model = getModel();

      // Act

      model.cleanResources();

      // Assert - Result

      var actual = userService.tempUser;

      Null expected;

      expect(actual, expected);
    });

    test('when model created and journal entries loaded, entries are filtered correctly', () async {
      // Arrange - Setup
      getAndRegisterJournalEntryServiceMock(initialEntries: testEntries);

      var model = getModel();

      // Act

      model.initialize();

      model.setFilteredJournalEntries(MoodType.awesome.text, '');

      // Assert - Result

      var actual = model.journalEntries.length;

      var expected = 2;

      expect(actual, expected);

      // Act

      model.setFilteredJournalEntries(MoodType.happy.text, '');

      // Assert - Result

      actual = model.journalEntries.length;

      expected = 1;

      expect(actual, expected);

      // Act

      model.setFilteredJournalEntries(MoodType.okay.text, '');

      // Assert - Result

      actual = model.journalEntries.length;

      expected = 1;

      expect(actual, expected);

      // Act

      model.setFilteredJournalEntries(MoodType.bad.text, '');

      // Assert - Result

      actual = model.journalEntries.length;

      expected = 0;

      expect(actual, expected);

      // Act

      model.setFilteredJournalEntries(MoodType.terrible.text, '');

      // Assert - Result

      actual = model.journalEntries.length;

      expected = 0;

      expect(actual, expected);

      // Act
      model.setFilteredJournalEntries('all', '');

      // Assert - Result

      actual = model.journalEntries.length;

      expected = 4;

      expect(actual, expected);
    });

    test('when currentUser called, then the currently authenticated user is logged in', () {
      // Arrange - Setup
      getAndRegisterUserServiceMock(testCurrentUser);

      final model = getModel();

      // Act

      final result = model.currentUser;

      // Assert - Results

      var actual = result;

      var expected = userService.currentUser;

      expect(actual, expected);
    });
  });
}
