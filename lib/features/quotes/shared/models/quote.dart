import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class Quote {
  int? id;
  String author;
  String quote;

  @JsonKey(name: "is_liked")
  bool isLiked;

  Quote({
    this.id,
    required this.author,
    required this.quote,
    required this.isLiked,
  });

  Map<String, dynamic> toJSON();
}
