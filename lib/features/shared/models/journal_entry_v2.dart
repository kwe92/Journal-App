import 'package:json_annotation/json_annotation.dart';

import 'package:journal_app/features/shared/services/services.dart';

part 'journal_entry_v2.g.dart';

/// domain model and DTO representing a journal entry
@JsonSerializable()
class JournalEntryV2 {
  @JsonKey(name: "id")
  int? entryID;

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
  JournalEntryV2({
    this.entryID,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JournalEntryV2.fromJSON(Map<String, dynamic> json) => _$JournalEntryV2FromJson(json);

  Map<String, dynamic> toJSON() => _$JournalEntryV2ToJson(this);

  // Map<String, dynamic> toMap() => {
  //       'id': entryID,
  //       'content': content,
  //       'mood_type': moodType,
  //       'created_at': createdAt.toString(),
  //       'updated_at': updatedAt.toString(),
  //     };

  // factory JournalEntryV2.fromMap(Map<String, dynamic> map) => JournalEntryV2(
  //       entryID: map['id'],
  //       content: map['content'],
  //       moodType: map['mood_type'],
  //       createdAt: DateTime.parse(map['created_at']),
  //       updatedAt: DateTime.parse(map['updated_at']),
  //     );

  @override
  String toString() {
    return 'JournalEntry(entryId: $entryID, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, moodType: $moodType)';
  }
}
