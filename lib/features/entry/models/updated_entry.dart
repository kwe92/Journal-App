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
}
