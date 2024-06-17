// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) => JournalEntry(
      entryID: (json['id'] as num?)?.toInt(),
      content: json['content'] as String,
      moodType: json['mood_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$JournalEntryToJson(JournalEntry instance) =>
    <String, dynamic>{
      'id': instance.entryID,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'mood_type': instance.moodType,
    };
