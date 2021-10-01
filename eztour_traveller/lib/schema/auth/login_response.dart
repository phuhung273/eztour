import 'package:eztour_traveller/mixins/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse with Response {

  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'user_id')
  String? userID;

  @JsonKey(name: 'user_name')
  String? username;

  @JsonKey(name: 'credential')
  String? credential;

  LoginResponse({
    this.accessToken,
    this.userID,
    this.username,
    this.credential,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}