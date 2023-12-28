import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// domain model and DTO representing an authenticated logged-in user
@JsonSerializable()
class User {
  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "password")
  String? password;
  User({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
  });

  factory User.fromJSON(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJSON() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password)';
  }
}
