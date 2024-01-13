import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/profile/profile_settings/ui/delete_profile_dialog_view_model.dart';

import '../../../../support/test_data.dart';
import '../../../../support/test_helpers.dart';

void main() {
  DeleteProfileDialogViewModel getModel() => DeleteProfileDialogViewModel();
  group('DeleteProfileDialogViewModel - ', () {
    setUpAll(() async {
      await registerSharedServices();
      getAndRegisterUserServiceMock(testCurrentUser);
    });

    test('when model created and currentUser getter method called, then the current user is returned', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      final result = model.currentUser;

      // Assert

      var actual = result;

      var expected = testTempUser.firstName = 'Yuujiro';

      expect(actual, expected);
    });

    test('when model created and currentUser getter method called, then the current user is returned', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      final result = model.currentUser;

      // Assert

      var actual = result;

      var expected = testTempUser.firstName = 'Yuujiro';

      expect(actual, expected);
    });
  });
}
