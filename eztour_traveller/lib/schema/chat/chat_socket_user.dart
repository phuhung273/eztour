import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_socket_user.g.dart';

const FIELD_USERID = 'userID';
const FIELD_USERNAME = 'username';
const FIELD_CONNECTED = 'connected';
const FIELD_MESSAGES = 'messages';

@JsonSerializable()
class ChatSocketUser {

  @JsonKey(name: FIELD_USERID)
  String userID;

  @JsonKey(name: FIELD_USERNAME)
  String username;

  @JsonKey(name: FIELD_CONNECTED)
  int connected;

  @JsonKey(name: FIELD_MESSAGES)
  List<ChatSocketMessage>? messages;

  ChatSocketUser({
    required this.userID,
    required this.username,
    required this.connected,
  });

  factory ChatSocketUser.fromJson(Map<String, dynamic> json) =>
      _$ChatSocketUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSocketUserToJson(this);


  Map<String, dynamic> toJsonWithoutMessages() => {
    FIELD_USERID: userID,
    FIELD_USERNAME: username,
    FIELD_CONNECTED: connected,
  };

}