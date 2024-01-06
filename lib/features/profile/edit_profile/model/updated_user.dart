import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'updated_user.g.dart';

/// domain model and DTO representing an updated user
@JsonSerializable()
class UpdatedUser extends BaseUser {
  UpdatedUser({
    super.firstName,
    super.lastName,
    super.email,
    super.phoneNumber,
  });

  factory UpdatedUser.fromJSON(Map<String, dynamic> json) => _$UpdatedUserFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$UpdatedUserToJson(this);

  @override
  String toString() {
    return 'UpdatedUser(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber)';
  }
}
