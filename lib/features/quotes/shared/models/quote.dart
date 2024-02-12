abstract class Quote {
  final String author;
  final String quote;
  bool isLiked;

  Quote({
    required this.author,
    required this.quote,
    required this.isLiked,
  });

  Map<String, dynamic> toJSON();
}
