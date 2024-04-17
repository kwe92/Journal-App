class LikedQuote {
  int? id;
  String author;
  String quote;
  bool isLiked;
  DateTime createdAt;

  LikedQuote({
    required this.id,
    required this.author,
    required this.quote,
    required this.isLiked,
    required this.createdAt,
  });

  factory LikedQuote.fromJSON(Map<String, dynamic> json) {
    return LikedQuote(
      id: json["id"] ?? 0,
      author: json["author"] ?? "",
      quote: json["quote"] ?? "",
      isLiked: json["is_liked"] != null && json["is_liked"] == '0' ? false : true,

      // isLiked: json["is_liked"] != null ? bool.parse(json["is_liked"]) : true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

  factory LikedQuote.fromJsonApiCall(Map<String, dynamic> json) {
    return LikedQuote(
      id: json["id"] ?? 0,
      author: json["a"] ?? "",
      quote: json["q"] ?? "",
      isLiked: json["is_liked"],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

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
