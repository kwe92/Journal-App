import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/entry/ui/entry_view_model.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  EntryviewModel getModel() => EntryviewModel(entry: testEntry);

  group('EntryviewModel - ', () {
    setUp(() async => await registerSharedServices());

    test('when model created and model initialize called, then content, entryController.text and moodColor are set', () {
      // Arrange - Setup
      getAndRegisterService<MoodService>(MoodService());

      var model = getModel();

      // Act

      model.initialize();

      // Assert - Result

      var actual = model.content == testEntry.content;

      var expected = true;

      expect(actual, expected);

      actual = model.entryController.text == testEntry.content;

      expected = true;

      expect(actual, expected);

      actual = model.moodColor != null;

      expected = true;

      expect(actual, expected);
    });
  });

  test('when model created and setContent called, then content is set', () {
    // Arrange - Setup

    const content = 'concentrated effort.';

    var model = getModel();

    // Act
    model.setContent(content);

    // Assert - Result

    var actual = model.content == content;

    var expected = true;

    expect(actual, expected);
  });

  test('when model created and setContent called followed by clearContent, then content is null', () {
    // Arrange - Setup

    const content = 'concentrated effort.';

    var model = getModel();

    // Act
    model.setContent(content);

    model.clearContent();

    // Assert - Result

    var actual = model.content == null;

    var expected = true;

    expect(actual, expected);
  });

  testWidgets('when model created and updateEntry called, then status ok returned', (tester) async {
    // Arrange - Setup

    WidgetsFlutterBinding.ensureInitialized();

    getAndRegisterService<ToastService>(ToastService());
    getAndRegisterService<MoodService>(MoodService());
    getAndRegisterJournalEntryServiceMock();
    getAndRegisterService<AppRouter>(AppRouter());

    var model = getModel();

    // Act

    model.initialize();

    dynamic result;

    await tester.pumpWidget(
      TestingWrapper(
        Scaffold(
          body: Builder(
            builder: (context) {
              () async {
                await model.updateEntry();
              }();

              return const Placeholder();
            },
          ),
        ),
      ),
    );

    // Assert - Result

    var actual = result;

    var expected = true;

    expect(actual, expected);
  });

  testWidgets('when model created and continueDelete called, then true returned', (tester) async {
    // Arrange - Setup

    WidgetsFlutterBinding.ensureInitialized();

    getAndRegisterService<ToastService>(ToastService());
    getAndRegisterService<MoodService>(MoodService());
    getAndRegisterJournalEntryServiceMock();
    getAndRegisterService<AppRouter>(AppRouter());

    var model = getModel();

    // Act

    // model.initialize();

    dynamic result;

    await tester.pumpWidget(
      TestingWrapper(
        Scaffold(
          body: Builder(
            builder: (context) {
              () async {
                const color = AppColors.moodAwesome;
                getAndRegisterToastServiceMock(context, color);
                result = await model.continueDelete(context, color);
              }();

              return const Placeholder();
            },
          ),
        ),
      ),
    );

    // Assert - Result

    var actual = result;

    var expected = true;

    expect(actual, expected);
  });

  test('if content has not changed, then isIdenticalContent returns true', () {
    // Arrange - Setup
    final model = getModel();

    // Act
    model.initialize();

    // Assert - Result
    var actual = model.isIdenticalContent;

    var expected = true;

    expect(actual, expected);
  });

  test('when model initialize called, then continentalTime, dayOfWeekByName, and timeOfDay return correct date and time information', () {
    // Arrange - Setup
    getAndRegisterService<TimeService>(TimeService());

    final model = getModel();

    // Act
    final result = model.continentalTime ==
            int.parse(timeService.getContinentalTime(
              testEntry.updatedAt.toLocal(),
            )) &&
        model.dayOfWeekByName ==
            timeService.dayOfWeekByName(
              testEntry.updatedAt.toLocal(),
            ) &&
        model.timeOfDay ==
            timeService.timeOfDay(
              testEntry.updatedAt.toLocal(),
            );

    // Assert - Result

    var actual = result;

    var expected = true;

    expect(actual, expected);
  });

  test('when currentUser called, then the currently authenticated user is logged in', () {
    // Arrange - Setup
    getAndRegisterUserServiceMock(testCurrentUser);

    final model = getModel();

    // Act

    final result = model.currentUser;

    // Assert - Results

    var actual = result;

    var expected = userService.currentUser;

    expect(actual, expected);
  });

  test('when serReadOnly called with false argument, then readOnly returns false', () {
    // Arrange - Setup

    final model = getModel();

    // Act
    model.setReadOnly(false);

    // Assert - Results

    var actual = model.readOnly;

    var expected = false;

    expect(actual, expected);
  });

  testWidgets('when model created and deleteEntry called, then true returned', (tester) async {
    // Arrange - Setup

    getAndRegisterService<ToastService>(ToastService());

    var model = getModel();

    // Act
    dynamic result;
    await tester.pumpWidget(
      TestingWrapper(
        Scaffold(
          body: Builder(
            builder: (context) {
              () async {
                result = await model.deleteEntry(testEntry.entryID);
              }();
              return const Placeholder();
            },
          ),
        ),
      ),
    );

    // Assert - Result
    var actual = result;

    var expected = true;

    expect(actual, expected);
  });
}
