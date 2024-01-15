import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view.dart';

import '../../../../support/test_helpers.dart';

// TODO: figure out why tests failing
void main() {
  group('SigninView', () {
    setUp(() async {
      await registerSharedServices();
    });

    testWidgets('...', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterService<ImageService>(ImageService());

      await tester.pumpWidget(
        TestingWrapper(
          SignInView(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Finders
      // TODO: figure out why image service causing issues | if you put a print statement after image service call in view model it will not print in test
      final loginText = find.byKey(const GlobalObjectKey('find-widget'));

      expect(loginText, findsOneWidget);
    });
  });
}
