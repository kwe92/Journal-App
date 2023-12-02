// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      entryId: json['id'] as int,
      uid: json['user_id'] as int,
      content: json['content'] as String,
      moodType: json['mood_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'user_id': instance.uid,
      'id': instance.entryId,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'mood_type': instance.moodType,
    };
