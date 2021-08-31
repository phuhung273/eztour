
import 'package:eztour_traveller/schema/chat/chat_handshake_auth.dart';
import 'package:eztour_traveller/schema/chat/chat_session_response.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:eztour_traveller/schema/chat/chat_user_disconnected_response.dart';
import 'package:eztour_traveller/schema/chat/chat_user_list_response.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

final Socket _socket = io('http://10.0.2.2:3000',
    OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build()
);

void initChat(String username){
  final Socket socket = Get.put(_socket);

  socket.auth = ChatHandshakeAuth(username: username).toJson();

  socket.on('session', (data){
    final response = ChatSessionResponse.fromJson(data as Map<String, dynamic>);
  });

  socket.on('users', (data){
    final response = ChatUserListResponse.fromJson(data as Map<String, dynamic>);
  });

  socket.on('user connected', (data){
    final response = ChatSocketUser.fromJson(data as Map<String, dynamic>);
  });

  socket.on('user disconnected', (data){
    final response = ChatUserDisconnectedResponse.fromJson(data as Map<String, dynamic>);
  });

  socket.disconnect().connect();
}