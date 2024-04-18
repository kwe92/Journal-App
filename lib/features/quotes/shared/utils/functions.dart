import 'package:journal_app/features/quotes/shared/models/quote.dart';

String shareQuote(Quote quote) => "${quote.quote}\n\n- ${quote.author}";
