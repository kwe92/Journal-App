import 'package:json_annotation/json_annotation.dart';

/// domain model and DTO representing an authenticated logged-in user
@JsonSerializable()
abstract class BaseUser {
  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "password")
  String? password;
  BaseUser({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJSON();

  @override
  String toString();
}
