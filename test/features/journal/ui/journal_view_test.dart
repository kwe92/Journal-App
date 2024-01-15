import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/journal/ui/journal_view.dart';
import 'package:journal_app/features/journal/ui/widget/add_button.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';

import '../../../support/test_helpers.dart';

void main() {
  Future<void> pumpView(WidgetTester tester) async {
    await tester.pumpWidget(
      const TestingWrapper.portal(
        JournalView(),
      ),
    );
  }

  group('JournalView - ', () {
    setUpAll(() async {
      await registerSharedServices();
      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<MoodService>(MoodService());
    });
    testWidgets('when view loaded and journal entries are empty, No entries text and add button are found', (tester) async {
      // Arrange - Setup

      FlutterError.onError = ignoreOverflowErrors;

      await pumpView(tester);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Act - Finders

      final textFinder = find.text("No entries, whats on your mind...");

      final addButtonFinder = find.byType(AddButton);

      // Assert - result

      expect(textFinder, findsOneWidget);

      expect(addButtonFinder, findsOneWidget);
    });

    testWidgets('when view loaded  and add button pressed, then navigate to Mood View', (tester) async {
      // Arrange - Setup

      FlutterError.onError = ignoreOverflowErrors;

      await pumpView(tester);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Act - Finders

      final addButtonFinder = find.byType(AddButton);

      // Assert - result

      expect(addButtonFinder, findsOneWidget);

      // Act

      await tester.tap(addButtonFinder);

      // TODO: figure out why verifyNever is throwing an error
      // verifyNever(appRouter.push(const MoodRoute()));
    });
  });
}
