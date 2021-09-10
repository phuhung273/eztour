import 'package:json_annotation/json_annotation.dart';

part 'chat_socket_message.g.dart';

const FIELD_ID = 'id';
const FIELD_CONTENT = 'content';
const FIELD_FROM = 'fromID';
const FIELD_TO = 'toID';

@JsonSerializable()
class ChatSocketMessage {

  @JsonKey(name: FIELD_ID)
  String id;

  @JsonKey(name: FIELD_CONTENT)
  String content;

  @JsonKey(name: FIELD_FROM)
  String from;

  @JsonKey(name: FIELD_TO)
  String to;

  ChatSocketMessage({
    required this.id,
    required this.content,
    required this.from,
    required this.to,
  });

  factory ChatSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatSocketMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSocketMessageToJson(this);

}