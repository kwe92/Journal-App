import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/profile/profile_settings/ui/delete_profile_dialog_view_model.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';

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

      var expected = testTempUser;

      expect(actual, expected);
    });

    test('when model created and setConfirmedEmail called with current user email, then emailMatch returns true', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.setConfirmedEmail(testCurrentUser.email!);

      final result = model.emailMatch;

      // Assert

      var actual = result;

      var expected = true;

      expect(actual, expected);
    });

    test(
        'when model created and confirmedEmail not equal to currentUser.email, then confirmValidAndMatchingEmail returns "emails do not match"',
        () {
      // Arrange - Setup

      getAndRegisterService<StringService>(StringService());
      final model = getModel();

      // Act
      var result = model.confirmValidAndMatchingEmail('incorrect@email.io');

      // Assert
      var actual = result;

      var expected = "emails do not match";

      expect(actual, expected);
    });

    test('when model created and deleteAccount called, then true is returned', () async {
      // Arrange - Setup

      getAndRegisterService<StringService>(StringService());
      getAndRegisterService<ToastService>(ToastService());
      getAndRegisterAuthServiceMock();

      final model = getModel();

      // Act
      var result = await model.deleteAccount();

      // Assert
      var actual = result;

      var expected = true;

      expect(actual, expected);
    });
  });
}
