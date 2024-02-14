import 'package:journal_app/features/quotes/shared/models/quote.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_imp.g.dart';

@JsonSerializable()
class QuoteImp extends Quote {
  QuoteImp({
    required super.author,
    required super.quote,
    required super.isLiked,
  });

  // factory QuoteImp.fromJSON(Map<String, dynamic> json) => _$QuoteImpFromJson(json);

  factory QuoteImp.fromJSON(Map<String, dynamic> json) => QuoteImp(
        author: json["a"],
        quote: json["q"],
        isLiked: json["is_liked"],
      );

  @override
  Map<String, dynamic> toJSON() => _$QuoteImpToJson(this);

  @override
  String toString() => "Quote(author: $author, quote: $quote, isLiked: $isLiked)";
}
