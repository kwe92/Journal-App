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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseUser &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.password == password;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^ lastName.hashCode ^ email.hashCode ^ phoneNumber.hashCode ^ password.hashCode;
  }
}
