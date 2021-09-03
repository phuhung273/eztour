
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/schema/chat/chat_handshake_auth.dart';
import 'package:eztour_traveller/schema/chat/chat_session_response.dart';
import 'package:eztour_traveller/schema/chat/chat_user_list_response.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

final Socket socket = io('http://10.0.2.2:3000',
    OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build()
);

void initChat(){
  final Socket _socket = Get.find();
  final LocalStorage localStorage = Get.find();
  final ChatUserDB userDB = Get.find();

  userDB.clear();

  final String username = localStorage.getUsername() ?? 'unknown';
  final String userID = localStorage.getUserID() ?? 'unknown';

  _socket.auth = ChatHandshakeAuth(username: username, userID: userID).toJson();

  _socket.on('session', (data){
    final response = ChatSessionResponse.fromJson(data as Map<String, dynamic>);

    localStorage.saveChatSessionID(response.sessionID);
  });

  _socket.on('users', (data){
    final ChatUserDB chatDB = Get.find();
    final response = ChatUserListResponse.fromJson(data as Map<String, dynamic>);

    chatDB.batchInsert(response.users);
  });

  _socket.disconnect().connect();
}