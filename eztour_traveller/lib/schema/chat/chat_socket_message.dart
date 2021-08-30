import 'package:json_annotation/json_annotation.dart';

part 'chat_socket_message.g.dart';

@JsonSerializable()
class ChatSocketMessage {

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'from')
  String from;

  @JsonKey(name: 'to')
  String to;

  ChatSocketMessage({
    required this.content,
    required this.from,
    required this.to,
  });

  factory ChatSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatSocketMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatSocketMessageToJson(this);

}