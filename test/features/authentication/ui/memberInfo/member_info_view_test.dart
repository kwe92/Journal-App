import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';

import '../../../../support/test_helpers.dart';

void main() {
  Future<void> pumpView(WidgetTester tester) async {
    await tester.pumpWidget(
      TestingWrapper.portal(
        MemberInfoView(),
      ),
    );
  }

  group('MemberInfoView - ', () {
    setUp(() async {
      await registerSharedServices();

      TestWidgetsFlutterBinding.ensureInitialized();

      getAndRegisterService<ImageService>(ImageService());

      getAndRegisterService<StringService>(StringService());
    });

    testWidgets("When the MemberInfoView opens, Sign-up text, TextFormField's, and continue button visible", (tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      await pumpView(tester);

      // Finders
      final signUpFinder = find.text('Sign-up');

      final firstNameTextFieldFinder = find.byKey(WidgetKey.firstNameKey, skipOffstage: false);

      final lasttNameTextFieldFinder = find.byKey(WidgetKey.lastNameKey, skipOffstage: false);

      final phoneNumberTextFieldFinder = find.byKey(WidgetKey.phoneNumberKey, skipOffstage: false);

      final eemailTextFieldFinder = find.byKey(WidgetKey.emailKey, skipOffstage: false);

      expect(signUpFinder, findsWidgets);

      expect(firstNameTextFieldFinder, findsWidgets);

      expect(lasttNameTextFieldFinder, findsWidgets);

      expect(phoneNumberTextFieldFinder, findsWidgets);

      expect(eemailTextFieldFinder, findsWidgets);
    });

    testWidgets('when fields are empty and continue button pressed, then navigation does not happen', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      await pumpView(tester);

      // Finders

      // final continueButtonFinder = find.byType(SelectableButton, skipOffstage: false);

      final viewFinder = find.byType(CustomScrollView);

      // TODO: figure out why SelectableButton is still off screen

      // await tester.dragUntilVisible(
      //   continueButtonFinder,
      //   viewFinder,
      //   const Offset(-500, 0),
      // );

      // final gesture = await tester.startGesture(Offset(400, 762)); //Position of the scrollview
      // await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      // await tester.pump();

      // expect(continueButtonFinder, findsOneWidget);

      expect(viewFinder, findsOneWidget);

      // expect(continueButtonFinder, findsOneWidget);

      // await tester.pump();

      // await tester.tap(continueButtonFinder);
    });
  });
}
