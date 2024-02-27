import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/widgets/email_sign_up.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';
import 'package:provider/provider.dart';
import '../../../../../support/test_helpers.dart';

void main() {
  Future<void> pumpView(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appModeService,
        builder: (context, child) {
          return TestingWrapper.portal(
            SignUpView(),
          );
        },
      ),
    );
  }

  group('SignUpView', () {
    setUp(() async {
      await registerSharedServices();
      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<StringService>(StringService());
    });

    testWidgets("When the Sign Up view opens, Sign-up text, TextFormField's and continue button visible - ", (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      getAndRegisterService<FlutterSecureStorage>(const FlutterSecureStorage());
      getAndRegisterService<AppModeService>(AppModeService());

      appModeService.setLightMode(true);

      await pumpView(tester);

      // Finders
      final signUpTextFinder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == 'Sign-up' && widget.style?.fontWeight == FontWeight.w700,
      );

      final emailSignupFinder = find.byType(EmailSignUp);

      final continueButtonFinder = find.byType(SelectableButton);

      expect(signUpTextFinder, findsOneWidget);

      expect(continueButtonFinder, findsOneWidget);

      expect(emailSignupFinder, findsOneWidget);
    });

    testWidgets('When the password field gains focus, then password requirements popup appears', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      getAndRegisterService<FlutterSecureStorage>(const FlutterSecureStorage());
      getAndRegisterService<AppModeService>(AppModeService());

      appModeService.setLightMode(true);

      await pumpView(tester);

      // Finders

      final modalFinder = find.text('Password must contain a capital letter');

      final initialPasswordFinder = find.byKey(WidgetKey.initialPasswordKey);

      final confirmPasswordFinder = find.byKey(WidgetKey.confirmPasswordKey);

      expect(initialPasswordFinder, findsOneWidget);

      expect(confirmPasswordFinder, findsOneWidget);

      expect(modalFinder, findsNothing);

      await tester.enterText(initialPasswordFinder, 'password');

      await tester.pumpAndSettle();

      expect(modalFinder, findsOneWidget);
    });
  });
}

// byWidgetPredicate

//   - finds a widget by using a widget predicate comparing as many properties as you like to be as granular as you want to bes