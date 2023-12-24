import 'package:json_annotation/json_annotation.dart';

part 'updated_user.g.dart';

/// UpdatedUser: represents a updated user
@JsonSerializable()
class UpdatedUser {
  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  String? email;

  UpdatedUser({
    this.firstName,
    this.lastName,
    this.email,
  });

  factory UpdatedUser.fromJSON(Map<String, dynamic> json) => _$UpdatedUserFromJson(json);

  Map<String, dynamic> toJSON() => _$UpdatedUserToJson(this);

  @override
  String toString() => 'UpdatedUser(firstName: $firstName, lastName: $lastName, email: $email)';
}
