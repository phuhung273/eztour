import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {

  @JsonKey(name: 'email')
  String username;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'device_name')
  String device;

  LoginRequest({
    required this.username,
    required this.password,
    required this.device,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

}