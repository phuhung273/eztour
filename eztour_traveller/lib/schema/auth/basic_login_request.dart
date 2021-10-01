import 'package:json_annotation/json_annotation.dart';

part 'basic_login_request.g.dart';

@JsonSerializable()
class BasicLoginRequest {

  @JsonKey(name: 'email')
  String username;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'device_name')
  String device;

  BasicLoginRequest({
    required this.username,
    required this.password,
    required this.device,
  });

  factory BasicLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$BasicLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BasicLoginRequestToJson(this);

}