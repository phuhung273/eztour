import 'package:json_annotation/json_annotation.dart';

part 'chat_handshake_auth.g.dart';

@JsonSerializable()
class ChatHandshakeAuth {

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'sessionID')
  String? sessionID;

  ChatHandshakeAuth({
    required this.username,
    this.sessionID,
  });

  factory ChatHandshakeAuth.fromJson(Map<String, dynamic> json) =>
      _$ChatHandshakeAuthFromJson(json);

  Map<String, dynamic> toJson() => _$ChatHandshakeAuthToJson(this);

}