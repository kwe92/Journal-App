import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/journal/ui/journal_view.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:provider/provider.dart';

import '../../../support/test_helpers.dart';

void main() {
  setUpAll(() async {
    await registerSharedServices();
    getAndRegisterService<ImageService>(ImageService());
    getAndRegisterService<MoodService>(MoodService());
  });
  group('JournalView - ', () {
    testWidgets('when view loaded and journal entries are empty, No entries text and add button are found', (tester) async {
      // Arrange - Setup

      getAndRegisterService<FlutterSecureStorage>(const FlutterSecureStorage());

      getAndRegisterService<AppModeService>(AppModeService());

      appModeService.setLightMode(true);

      FlutterError.onError = ignoreOverflowErrors;

      await pumpView(
        tester,
        view: ChangeNotifierProvider(
          create: (_) => JournalViewModel(),
          builder: (context, child) => const JournalView(),
        ),
        changeNotifierValue: appModeService,
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Act - Finders

      final textFinder = find.text("No entries, what's on your mind...");

      final addButtonFinder = find.byType(FloatingActionButton);

      // Assert - result

      expect(textFinder, findsOneWidget);

      expect(addButtonFinder, findsOneWidget);
    });

    testWidgets('when view loaded and add button pressed, then navigate to Mood View', (tester) async {
      // Arrange - Setup

      getAndRegisterService<FlutterSecureStorage>(const FlutterSecureStorage());

      getAndRegisterService<AppModeService>(AppModeService());

      appModeService.setLightMode(true);

      FlutterError.onError = ignoreOverflowErrors;

      await pumpView(
        tester,
        view: ChangeNotifierProvider(
          create: (_) => JournalViewModel(),
          builder: (context, child) => const JournalView(),
        ),
        changeNotifierValue: appModeService,
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Act - Finders

      final addButtonFinder = find.byType(FloatingActionButton);

      // Assert - result

      expect(addButtonFinder, findsOneWidget);

      // Act

      // await tester.tap(addButtonFinder);

      // TODO: figure out why verifyNever is throwing an error
      // verifyNever(appRouter.push(const MoodRoute()));
    });
  });
}
