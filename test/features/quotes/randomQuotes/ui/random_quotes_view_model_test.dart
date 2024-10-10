import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view_model.dart';

import '../../../../support/test_data.dart';
import '../../../../support/test_helpers.dart';

void main() {
  RandomQuotesViewModel getModel() => RandomQuotesViewModel();

  setUpAll(() async {
    await registerSharedServices();
    getAndRegisterZenQuotesApiService();
    getAndRegisterLikedQuotesService();
  });
  group("RandomQuotesViewModel - ", () {
    test("when model created and initialized, then quotes are populated", () async {
      // Arrange - Setup

      final model = getModel();

      // Act
      await model.initialize();

      // Assert - Result

      expect(model.quotes.length, testQuotes.length);
    });

    test("when quote is liked, then quote is removed from list of quotes", () async {
      // Arrange - Setup
      final model = getModel();

      // Act
      await model.initialize();
      await model.setLikedForQuote(model.quotes[0]);

      // Assert - Result
      expect(model.quotes.length, 2);
    });
  });
}
