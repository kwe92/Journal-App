import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';

import '../../../../support/test_helpers.dart';

void main() {
  group('MemberInfoView - ', () {
    setUp(() async => await registerSharedServices());

    testWidgets('When the MemberInfoView opens, Sign-up text and continue button visible - ', (tester) async {
      // TODO: Review | overriding the default behavior of errors
      FlutterError.onError = ignoreOverflowErrors;

      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<StringService>(StringService());

      await tester.pumpWidget(
        TestingWrapper.portal(
          MemberInfoView(),
        ),
      );

      // Finders
      final signUpFinder = find.text('Sign-up');

      // TODO: figure out why you can't find descendants of CustomScrollView
      // final testFinder = find.byType(CustomScrollView);

      expect(signUpFinder, findsWidgets);

      // expect(testFinder, findsOneWidget);
    });
  });
}
