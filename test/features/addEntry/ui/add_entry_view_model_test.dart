import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:mockito/mockito.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  /// returns ViewModel for this test
  AddEntryViewModel getModel() => AddEntryViewModel();
  group('AddEntryViewModel - ', () {
    // registered setup function ran once before all tests
    setUpAll(
      () async {
        // register required depenencies
        await registerSharedServices();

        // TODO: do we even need this stubbed client call?
        // stub api call with Client
        when(
          locator.get<Client>().post(
                Uri.parse(testHost + Endpoint.entries.path),
                headers: anyNamed('headers'),
              ),
        ).thenAnswer(
          // TODO do i need to actually pass an updated entry json string
          (_) async => Response((''), 200),
        );
      },
    );

    test('when model is created and initialized, mood color is the correct color', () {
      // Arrange - Setup

      var moodType = MoodType.awesome.text;

      getAndRegisterMoodServiceMock(moodType, 20);

      var model = getModel();

      // Act

      model.initialize(moodType, DateTime.now());

      // Assert - Result

      var actual = model.moodColor;

      var expected = AppColors.moodAwesome;

      expect(actual, expected);
    });

    test('when user is authenticated, currentUser method returns correct user object', () {
      // Arrange - Setup
      getAndRegisterUserServiceMock(testCurrentUser);

      final model = getModel();

      // Act

      var actual = model.currentUser;

      // Assert - Result

      var expected = testCurrentUser;

      expect(actual, expected);
    });

    test('when model is initialized, getContinentalTime, dayOfWeekByName, and timeOfDay retrieve the correct values from the timeService',
        () {
      // Arrange - Setup

      final now = DateTime.now();

      getAndRegisterTimeServiceMock(now);

      final model = getModel();

      // Act

      model.initialize(MoodType.awesome.text, now);

      dynamic actual = model.continentalTime;

      // Assert - Result

      dynamic expected = int.parse(timeService.getContinentalTime(now));

      expect(actual, expected);

      actual = model.dayOfWeekByName;

      expected = timeService.dayOfWeekByName(now);

      expect(actual, expected);

      actual = model.timeOfDay;

      expected = timeService.timeOfDay(now);

      expect(actual, expected);
    });

    test('when setContent called, content is not empty', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      var content = 'Having difficulty when you want difficulty is okay.';

      model.setContent(content);

      dynamic actual = model.content;

      dynamic expected = content;

      // Assert - Result

      expect(actual, expected);

      actual = model.ready;

      expected = true;

      // Assert - Result

      expect(actual, expected);
    });

    test('when content is set and clearContent called, content is null', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      var content = 'Having difficulty when you want difficulty is okay.';

      model.setContent(content);

      model.clearContent();

      var actual = model.content;

      Null expected;

      // Assert - Result

      expect(actual, expected);
    });

    // TODO: work on test

    // test('', () async {
    //   // Arrange - Setup

    //   var model = getModel();

    //   // Act

    //   getAndRegisterJournalEntryServiceMock(
    //       newEntry: NewEntry(content: 'compound intrest is the eighth wonder of the world.', moodType: MoodType.okay.text));

    //   var actual = await model.addEntry(MoodType.okay.text, 'compound intrest is the eighth wonder of the world.');

    //   print(actual);

    //   // model.addEntry(MoodType.okay.text, 'compound intrest is the eighth wonder of the world.');

    //   // Assert - Result

    //   // var actual = model.moodColor;

    //   var expected = true;

    //   // expect(actual, expected);
    // });
  });
}
