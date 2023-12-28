import 'package:json_annotation/json_annotation.dart';

import 'package:journal_app/features/shared/services/services.dart';

part 'journal_entry.g.dart';

/// domain model and DTO representing a journal entry
@JsonSerializable()
class JournalEntry {
  @JsonKey(name: "user_id")
  final int uid;

  @JsonKey(name: "id")
  final int entryId;

  final String content;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  @JsonKey(name: "mood_type")
  final String moodType;

  String get dateString {
    return timeService.getStringFromDate(updatedAt);
  }

  /// Domain model and DTO for json serialization.
  const JournalEntry({
    required this.entryId,
    required this.uid,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JournalEntry.fromJSON(Map<String, dynamic> json) => _$JournalEntryFromJson(json);

  Map<String, dynamic> toJSON() => _$JournalEntryToJson(this);

  @override
  String toString() {
    return 'JournalEntry(uid: $uid, entryId: $entryId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, moodType: $moodType)';
  }
}
