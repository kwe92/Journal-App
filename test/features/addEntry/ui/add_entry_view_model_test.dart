import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
import 'package:journal_app/features/shared/factory/factory.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:mockito/mockito.dart';

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

      var model = getModel();

      var moodType = MoodType.awesome.text;

      getAndRegisterMoodServiceMock(moodType, 20);

      // Act

      model.initialize(moodType);

      // Assert - Result

      var actual = model.moodColor;

      var expected = AppColors.moodAwesome;

      expect(actual, expected);
    });

    test('when user is authenticated, currentUser method returns correct user object', () {
      // Arrange - Setup

      final model = getModel();

      final currentUser = AbstractFactory.createUser(
        userType: UserType.curentUser,
        firstName: 'Baki',
        lastName: 'Hanma',
        email: 'baki@grappler.io',
        phoneNumber: '+11234567890',
      );

      getAndRegisterUserServiceMock(currentUser);

      // Act

      var actual = model.currentUser;

      // Assert - Result

      var expected = currentUser;

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
