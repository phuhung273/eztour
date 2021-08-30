import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_socket_user.g.dart';

@JsonSerializable()
class ChatSocketUser {

  @JsonKey(name: 'userID')
  String userID;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'connected')
  bool connected;

  @JsonKey(name: 'messages')
  List<ChatSocketMessage> messages;

  ChatSocketUser({
    required this.userID,
    required this.username,
    required this.connected,
    required this.messages,
  });

  factory ChatSocketUser.fromJson(Map<String, dynamic> json) =>
      _$ChatSocketUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSocketUserToJson(this);

}