// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedUser _$UpdatedUserFromJson(Map<String, dynamic> json) => UpdatedUser(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
    )..password = json['password'] as String?;

Map<String, dynamic> _$UpdatedUserToJson(UpdatedUser instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
    };
