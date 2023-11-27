import 'package:json_annotation/json_annotation.dart';
part 'token_response.g.dart';

/// TokenResponse: model for access token.
@JsonSerializable()
class TokenResponse {
  @JsonKey(name: "jwt")
  final String accessToken;

  const TokenResponse({required this.accessToken});

  factory TokenResponse.fromJSON(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJSON() => _$TokenResponseToJson(this);
}
