import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';

import '../../../../support/test_data.dart';
import '../../../../support/test_helpers.dart';

void main() {
  group("LikedQuotesViewModel - ", () {
    LikedQuotesViewModel getModel() => LikedQuotesViewModel();

    setUpAll(() async {
      await registerSharedServices();
      getAndRegisterZenQuotesApiService();
      getAndRegisterLikedQuotesService();
    });

    test("when model created and likedQuotes called, then the correct number of liked quotes are returned", () async {
      // Arrange - Setup
      final model = getModel();

      // Act
      await model.initialize();
      var actual = model.likedQuotes.length;

      // Assert - Result
      expect(actual, testLikedQuotes.length);
    });
    test("when removeLikedQuote called, then quote is removed from the list of liked quotes", () async {
      // Arrange - Setup
      final model = getModel();

      // Act
      await model.initialize();

      model.removeLikedQuote(testLikedQuotes[0]);

      var actual = model.likedQuotes.length;

      // Assert - Result
      expect(actual, 2);
    });
  });
}
