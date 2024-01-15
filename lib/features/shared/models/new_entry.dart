import 'package:json_annotation/json_annotation.dart';

part 'new_entry.g.dart';

/// domain model and DTO representing a new journal entry
@JsonSerializable()
class NewEntry {
  final String content;

  @JsonKey(name: "mood_type")
  final String moodType;

  const NewEntry({
    required this.content,
    required this.moodType,
  });

  factory NewEntry.fromJSON(Map<String, dynamic> json) => _$NewEntryFromJson(json);

  Map<String, dynamic> toJSON() => _$NewEntryToJson(this);

  @override
  String toString() => 'NewEntry(content: $content, moodType: $moodType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewEntry && other.content == content && other.moodType == moodType;
  }

  @override
  int get hashCode => content.hashCode ^ moodType.hashCode;
}
