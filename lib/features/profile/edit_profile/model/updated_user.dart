import 'package:json_annotation/json_annotation.dart';

part 'updated_user.g.dart';

/// domain model and DTO representing an updated user
@JsonSerializable()
class UpdatedUser {
  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  UpdatedUser({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
  });

  factory UpdatedUser.fromJSON(Map<String, dynamic> json) => _$UpdatedUserFromJson(json);

  Map<String, dynamic> toJSON() => _$UpdatedUserToJson(this);

  @override
  String toString() {
    return 'UpdatedUser(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber)';
  }
}
