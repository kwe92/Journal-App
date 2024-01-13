import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';

import '../../../../support/test_helpers.dart';

void main() {
  SignInViewModel getModel() => SignInViewModel();

  group('SignInViewModel - ', () {
    setUp(() async {
      await registerSharedServices();
      getAndRegisterImageServiceMock();
    });

    testWidgets('when model initialized, then image created and loading state set to false', (tester) async {
      // Arrange - Setup

      final model = getModel();

      // Act

      await tester.pumpWidget(TestingWrapper(
        Builder(builder: (context) {
          model.initialize(context);

          return const Placeholder();
        }),
      ));

      // waits for all animations to complete
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Assert - Result
      var actual = model.mindfulImage != null;

      var expected = true;

      expect(actual, expected);

      actual = model.isLoading!;

      expected = false;

      expect(actual, expected);
    });

    test('when model created and setEmail and setPassword called with values, then model is ready', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.setEmail('consistent.discipline.ip');

      model.setPassword('persistence');

      // Assert - Result
      var actual = model.ready;

      var expected = true;

      expect(actual, expected);
    });

    test('when model created and setObscure called with an argument of false, then obscurePassword is false', () async {
      // Arrange - Setup

      final model = getModel();

      // Act

      var loginEmail = 'consistent.discipline.ip';

      var loginPassword = 'persistence';

      getAndRegisterAuthService(loginEmail: loginEmail, loginPassword: loginPassword);

      getAndRegisterService<ToastService>(ToastService());

      model.setEmail(loginEmail);

      model.setPassword(loginPassword);

      var result = await model.signInWithEmail();

      // Assert - Result
      var actual = result;

      var expected = true;

      expect(actual, expected);
    });

    test('when model created and signInWithEmail, true value returned', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.setObscure(false);

      // Assert - Result
      var actual = model.obscurePassword;

      var expected = false;

      expect(actual, expected);
    });
  });
}
