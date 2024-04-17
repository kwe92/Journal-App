import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';

String shareQuote(LikedQuote quote) => "${quote.quote}\n\n- ${quote.author}";
