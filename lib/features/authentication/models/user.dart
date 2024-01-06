import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// domain model and DTO representing an authenticated logged-in user
@JsonSerializable()
class User extends BaseUser {
  User({
    super.firstName,
    super.lastName,
    super.phoneNumber,
    super.email,
    super.password,
  });

  factory User.fromJSON(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, password: $password)';
  }
}
