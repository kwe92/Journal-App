import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/mood/ui/mood_view_model.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';

import '../../../support/test_helpers.dart';

void main() {
  MoodViewModel getModel() => MoodViewModel();

  setUpAll(() async => await registerSharedServices());

  group('MoodViewModel - ', () {
    test('when model created and setIndex called, then the value used to set selectedIndex matches actual selectedIndex value', () {
      // Arrange - Setup
      final model = getModel();

      const selectedIndex = 2;

      // Act
      model.setIndex(selectedIndex);

      // Assert - Result
      var actual = model.selectedIndex;

      var expected = selectedIndex;

      expect(actual, expected);
    });

    test('when model created and setMoodType called, then the value used to set moodType matches actual moodType value', () {
      // Arrange - Setup
      final model = getModel();

      final moodType = MoodType.okay.text;

      // Act
      model.setMoodType(moodType);

      // Assert - Result
      var actual = model.moodType;

      var expected = moodType;

      expect(actual, expected);
    });

    test('when model created and moods called, then moods returns List<Mood> and it is not empty', () {
      // Arrange - Setup

      getAndRegisterService<MoodService>(MoodService());

      final model = getModel();

      // Act

      // Assert - Result
      dynamic actual = model.moods.runtimeType;

      dynamic expected = List<Mood>;

      expect(actual, expected);

      actual = model.moods.isNotEmpty;

      expected = true;

      expect(actual, expected);
    });
  });
}
