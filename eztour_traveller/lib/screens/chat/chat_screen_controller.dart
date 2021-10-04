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
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

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

  final uuid = const Uuid();

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

      final result = await _chatDB.addMessage(response);
      if(result > 0){
        users[response.from]?.messages?.add(response);
        users.refresh();
      }
    });

  }

  Future sendStringMessage(ChatMessage newMessage, String toID) async {
    if(newMessage.text == null || newMessage.text!.isEmpty){
      return;
    }

    final newSocketMessage = ChatSocketMessage(
      id: uuid.v4(),
      content: newMessage.text!,
      from: _localStorage.getUserID()!,
      to: toID,
      type: EnumToString.convertToString(MessageType.STRING),
    );

    _socket.emitWithAck('private message', newSocketMessage, ack: (data) {
      if(data != null){
        final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);

        _sendMessage(response, newMessage, toID);
      }
    });

  }

  Future sendImageMessage(String base64Image, String toID) async {
    final newSocketMessage = ChatSocketMessage(
      id: uuid.v4(),
      content: base64Image,
      from: _localStorage.getUserID()!,
      to: toID,
      type: EnumToString.convertToString(MessageType.IMAGE),
    );

    _socket.emitWithAck('private message', newSocketMessage, ack: (data) {
      if(data != null){
        final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);
        final newMessage = ChatMessage(
          text: '',
          user: ChatUser(
              uid: newSocketMessage.from
          ),
          image: '$CHAT_PUBLIC_URL/${response.content}',
        );

        _sendMessage(response, newMessage, toID);
      }
    });
  }

  Future sendLocationMessage(String toID) async {

    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    final newSocketMessage = ChatSocketMessage(
      id: uuid.v4(),
      content: '${_locationData.latitude},${_locationData.longitude}',
      from: _localStorage.getUserID()!,
      to: toID,
      type: EnumToString.convertToString(MessageType.LOCATION),
    );

    _socket.emitWithAck('private message', newSocketMessage, ack: (data) {
      if(data != null){
        final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);
        final newMessage = ChatMessage(
          text: response.content,
          user: ChatUser(
              uid: newSocketMessage.from
          ),
          image: '',
        );

        _sendMessage(response, newMessage, toID);
      }
    });
  }

  Future _sendMessage(ChatSocketMessage socketMessage, ChatMessage chatMessage, String toID) async {
    final result = await _chatDB.addMessage(socketMessage);

    if(result > 0){
      users[toID]?.messages?.add(socketMessage);
      users.refresh();
    }
  }

  @override
  void onClose() {
    super.onClose();
    _socket.disconnect();
    _socket.dispose();
  }

}