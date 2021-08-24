import 'package:json_annotation/json_annotation.dart';

part 'basic_auth_credential.g.dart';

@JsonSerializable()
class BasicAuthCredential {

  String username;
  String password;

  BasicAuthCredential({
    required this.username,
    required this.password,
  });

  factory BasicAuthCredential.fromJson(Map<String, dynamic> json) =>
      _$BasicAuthCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$BasicAuthCredentialToJson(this);

}