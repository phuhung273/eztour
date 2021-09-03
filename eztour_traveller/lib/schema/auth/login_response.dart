import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {

  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'user_id')
  String? userID;

  @JsonKey(name: 'user_name')
  String? username;

  LoginResponse({
    required this.accessToken,
    required this.userID,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}