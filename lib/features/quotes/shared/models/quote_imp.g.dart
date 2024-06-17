// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_imp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteImp _$QuoteImpFromJson(Map<String, dynamic> json) => QuoteImp(
      author: json['author'] as String,
      quote: json['quote'] as String,
      isLiked: json['is_liked'] as bool,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$QuoteImpToJson(QuoteImp instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'quote': instance.quote,
      'is_liked': instance.isLiked,
    };
