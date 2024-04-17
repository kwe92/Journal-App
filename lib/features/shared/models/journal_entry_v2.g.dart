// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntryV2 _$JournalEntryV2FromJson(Map<String, dynamic> json) =>
    JournalEntryV2(
      entryID: json['id'] as int?,
      content: json['content'] as String,
      moodType: json['mood_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$JournalEntryV2ToJson(JournalEntryV2 instance) =>
    <String, dynamic>{
      'id': instance.entryID,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'mood_type': instance.moodType,
    };
