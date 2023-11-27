import 'package:journal_app/features/shared/utilities/json_utilities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry {
  @JsonKey(name: "user_id")
  final int uid;

  final String content;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  String get dateString {
    return getStringFromDate(updatedAt);
  }

  /// Entry: model representing expected json input for an entry.
  const Entry({
    required this.uid,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Entry.fromJSON(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJSON() => _$EntryToJson(this);

  @override
  String toString() {
    return 'Entry(uid: $uid, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
