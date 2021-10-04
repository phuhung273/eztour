import 'package:dash_chat/dash_chat.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/schema/chat/chat_handshake_auth.dart';
import 'package:eztour_traveller/schema/chat/chat_session_response.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:eztour_traveller/schema/chat/chat_user_disconnected_response.dart';
import 'package:eztour_traveller/schema/chat/chat_user_list_response.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatScreenController());
  }
}

class ChatScreenController extends GetxController {
  final ChatUserDB _chatDB = Get.find();

  final Socket _socket = Get.find();

  final LocalStorage _localStorage = Get.find();

  final users = <String, ChatSocketUser>{}.obs;

  @override
  Future onInit() async {
    super.onInit();

    _chatDB.clear();

    final String username = _localStorage.getUsername() ?? 'unknown';
    final String userID = _localStorage.getUserID() ?? 'unknown';

    _socket.auth = ChatHandshakeAuth(username: username, userID: userID).toJson();

    _socket.disconnect().connect();

    _socket.on('session', (data){
      final response = ChatSessionResponse.fromJson(data as Map<String, dynamic>);

      _localStorage.saveChatSessionID(response.sessionID);
    });

    _socket.on('users', (data) async {
      final response = ChatUserListResponse.fromJson(data as Map<String, dynamic>);

      await _chatDB.batchInsert(response.users);

      for(final user in response.users){
        users[user.userID] = user;
      }

    });

    _socket.on('user connected', (data){
      final response = ChatSocketUser.fromJson(data as Map<String, dynamic>);
      users[response.userID]?.connected = 1;
      users.refresh();
    });

    _socket.on('user disconnected', (data){
      final response = ChatUserDisconnectedResponse.fromJson(data as Map<String, dynamic>);
      users[response.userID]?.connected = 0;
      users.refresh();
    });

    _socket.on('private message', (data) async {
      final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);
      final newMessage = ChatMessage(
        id: response.id,
        text: response.content,
        user: ChatUser(
          uid: response.from,
        ),
      );

      if(response.type == EnumToString.convertToString(MessageType.IMAGE)){
        newMessage.image = '$CHAT_PUBLIC_URL/${newMessage.text}';
        newMessage.text = '';
      } else if(response.type == EnumToString.convertToString(MessageType.LOCATION)){
        newMessage.image = '';
      }

      // final result = await _chatDB.addMessage(response);
      // if(result > 0){
      //   users[response.from]?.messages?.add(response);
      //   users.refresh();
      // }

      final result = await _chatDB.addMessage(response);
      users[response.from]?.messages?.add(response);
      users.refresh();
    });

  }

  void addMessage(String recipientID, ChatSocketMessage message){
    users[recipientID]?.messages?.add(message);
    users.refresh();
  }
}