import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
import 'package:journal_app/features/shared/services/api_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  /// returns ViewModel for this test
  AddEntryViewModel getModel() => AddEntryViewModel();

  // registered setup function ran once before all tests
  setUpAll(
    () async {
      // register required depenencies
      await registerSharedServices();

      // stub api call with Client
      when(locator.get<Client>().post(
            Uri.parse(testHost + Endpoint.entries.path),
            headers: anyNamed('headers'),
          )).thenAnswer((_) async => Response((''), 200));
    },
  );
  group('AddEntryViewModel - ', () {
    test('when model is created and initialized, mood color is the correct color', () {
      // Arrange - Setup

      var moodType = MoodType.awesome.text;

      getAndRegisterMoodServiceMock(moodType, 20);

      var model = getModel();

      // Act

      model.initialize(moodType);

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

      model.clearVariables();

      var actual = model.content;

      var expected = '';

      // Assert - Result

      expect(actual, expected);
    });

    // TODO: Refactor test

    // testWidgets('when addEntry called, then return status ok', (tester) async {
    //   // Arrange - Setup

    //   TestWidgetsFlutterBinding.ensureInitialized();

    //   getAndRegisterService<ToastService>(ToastService());

    //   getAndRegisterService<AppRouter>(AppRouter());

    //   var model = getModel();

    //   final DatabaseService databaseService = getAndRegisterService<DatabaseService>(DatabaseService());

    //   databaseService.initialize();

    //   final result = await model.addEntry(MoodType.okay.text, 'compound intrest is the eighth wonder of the world.');

    //   // Act

    //   // Assert - Result

    //   var actual = result;

    //   var expected = true;

    //   expect(actual, expected);
    // });
  });
}
