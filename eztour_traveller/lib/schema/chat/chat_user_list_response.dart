import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_user_list_response.g.dart';

@JsonSerializable()
class ChatUserListResponse {

  @JsonKey(name: 'users')
  List<ChatSocketUser> users;

  ChatUserListResponse({
    required this.users,
  });

  factory ChatUserListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatUserListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserListResponseToJson(this);

}