import 'package:json_annotation/json_annotation.dart';

part 'updated_entry.g.dart';

/// domain model and DTO for updating an users entry.
@JsonSerializable()
class UpdatedEntry {
  @JsonKey(name: "id")
  int? entryId;
  String? content;

  UpdatedEntry({
    required this.entryId,
    required this.content,
  });

  factory UpdatedEntry.fromJSON(Map<String, dynamic> json) => _$UpdatedEntryFromJson(json);

  Map<String, dynamic> toJSON() => _$UpdatedEntryToJson(this);

  @override
  String toString() => 'UpdatedEntry(entryId: $entryId, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdatedEntry && other.entryId == entryId && other.content == content;
  }

  @override
  int get hashCode => entryId.hashCode ^ content.hashCode;
}
