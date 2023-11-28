import 'package:json_annotation/json_annotation.dart';
part 'new_entry.g.dart';

@JsonSerializable()
class NewEntry {
  String? content;

  NewEntry({required this.content});

  factory NewEntry.fromJSON(Map<String, dynamic> json) => _$NewEntryFromJson(json);

  Map<String, dynamic> toJSON() => _$NewEntryToJson(this);
}
