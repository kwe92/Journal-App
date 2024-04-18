import 'package:journal_app/features/quotes/shared/models/quote.dart';

class LikedQuote extends Quote {
  DateTime createdAt;

  LikedQuote({
    super.id,
    required super.author,
    required super.quote,
    required super.isLiked,
    required this.createdAt,
  });

  factory LikedQuote.fromJSON(Map<String, dynamic> json) => LikedQuote(
        id: json["id"] ?? 0,
        author: json["author"] ?? "",
        quote: json["quote"] ?? "",
        isLiked: json["is_liked"] != null && json["is_liked"] == '0' ? false : true,
        createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      );
  @override
  Map<String, dynamic> toJSON() => {
        // 'id': id,
        'author': author,
        'quote': quote,
        'is_liked': isLiked.toString(),
        'created_at': createdAt.toString(),
      };

  @override
  String toString() => "Quote(author: $author, quote: $quote, isLiked: $isLiked)";
}
