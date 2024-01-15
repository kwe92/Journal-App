import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';

import '../../../../support/test_data.dart';
import '../../../../support/test_helpers.dart';

void main() {
  ProfileSettingsViewModel getModel() => ProfileSettingsViewModel();
  group('ProfileSettingsViewModel - ', () {
    setUp(() async => registerSharedServices());

    test(
        'when model created currentUser, userFullName, and userEmail called, then created currentUser, userFullName, and userEmail matches currently authenticated user info',
        () {
      // Arrange - Setup
      getAndRegisterUserServiceMock(testCurrentUser);

      final model = getModel();

      // Act
      final result = model.currentUser == userService.currentUser &&
          model.userFullName == "${testCurrentUser.firstName} ${testCurrentUser.lastName}" &&
          model.userEmail == testCurrentUser.email;

      // Assert - result

      var actual = result;

      var expected = true;

      expect(actual, expected);
    });

    testWidgets('when deleteAccountPopupMenu, account is deleted and nothing is returned', (tester) async {
      // Arrange - Setup

      final model = getModel();

      // Act
      await tester.pumpWidget(
        TestingWrapper.portal(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  getAndRegisterToastServiceMock(context);

                  model.deleteAccountPopupMenu(context);

                  return const Placeholder();
                },
              ),
            ),
          ),
        ),
      );

      // Assert
    });
  });
}
