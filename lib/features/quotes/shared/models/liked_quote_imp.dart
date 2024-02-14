import 'package:journal_app/features/quotes/shared/models/quote.dart';

class LikedQuoteImp extends Quote {
  int userId;

  LikedQuoteImp({
    required super.id,
    required this.userId,
    required super.author,
    required super.quote,
    required super.isLiked,
  });

  factory LikedQuoteImp.fromJSON(Map<String, dynamic> json) {
    return LikedQuoteImp(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      author: json["author"] ?? "",
      quote: json["quote"] ?? "",
      isLiked: json["is_liked"] ?? true,
    );
  }
  @override
  Map<String, dynamic> toJSON() => {
        // TODO: implement
      };

  @override
  String toString() => "Quote(author: $author, quote: $quote, isLiked: $isLiked)";
}
