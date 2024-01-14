import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import '../../../../../support/test_helpers.dart';

void main() {
  group('SignUpView', () {
    setUp(() async => await registerSharedServices());

    testWidgets('When the Sign Up view opens, Sign-up text and continue button visible - ', (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<StringService>(StringService());

      await tester.pumpWidget(
        TestingWrapper.portal(
          SignUpView(),
        ),
      );

      // Finders
      final signUpFinder = find.text('Sign-up');

      final continueButtonFinder = find.byType(SelectableButton);

      expect(signUpFinder, findsWidgets);

      expect(continueButtonFinder, findsWidgets);
    });
  });
}
