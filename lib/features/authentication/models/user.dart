import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

/// User: represents a user that is logged-in or onboarding
@JsonSerializable()
class User {
  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  User({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
  });

  factory User.fromJSON(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJSON() => _$UserToJson(this);
}
