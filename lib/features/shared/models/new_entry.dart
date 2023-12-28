import 'package:json_annotation/json_annotation.dart';
part 'new_entry.g.dart';

/// domain model and DTO representing a new journal entry
@JsonSerializable()
class NewEntry {
  final String content;

  @JsonKey(name: "mood_type")
  final String moodType;

  NewEntry({
    required this.content,
    required this.moodType,
  });

  factory NewEntry.fromJSON(Map<String, dynamic> json) => _$NewEntryFromJson(json);

  Map<String, dynamic> toJSON() => _$NewEntryToJson(this);
}
