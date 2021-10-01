import 'package:json_annotation/json_annotation.dart';

part 'credential_login_request.g.dart';

@JsonSerializable()
class CredentialLoginRequest {

  @JsonKey(name: 'credential')
  String credential;

  @JsonKey(name: 'device_name')
  String device;

  CredentialLoginRequest({
    required this.credential,
    required this.device,
  });

  factory CredentialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$CredentialLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialLoginRequestToJson(this);

}