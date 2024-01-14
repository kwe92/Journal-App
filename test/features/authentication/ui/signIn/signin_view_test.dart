import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';

import '../../../../support/test_helpers.dart';

// TODO: figure out why tests failing
void main() {
  group('SigninView', () {
    setUp(() async {
      await registerSharedServices();
    });

    testWidgets('...', (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      getAndRegisterService<ImageService>(ImageService());

      await tester.pumpWidget(
        TestingWrapper(
          SignInView(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Finders
      final loginText = find.byType(DecorationImage);

      expect(loginText, findsOneWidget);
    });
  });
}
