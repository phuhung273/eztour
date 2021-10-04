import 'package:dash_chat/dash_chat.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:eztour_traveller/screens/chat/chat_screen_controller.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

class MessageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageScreenController());
  }
}

class MessageScreenController extends GetxController {

  final messages = List<ChatMessage>.empty().obs;

  final Socket _socket = Get.find();
  final LocalStorage _localStorage = Get.find();

  final String _destinationID = Get.arguments as String;

  final ChatUserDB _chatUserDB = Get.find();

  final ChatScreenController _mainController = Get.find();
  final name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    List<ChatSocketMessage> savedMessages = [];

    final user = _mainController.users[_destinationID];
    if(user != null && user.messages != null){
      savedMessages = _mainController.users[_destinationID]!.messages!;
      name.value = user.username;
    }

    messages.assignAll(savedMessages.map((e) {
      final message = ChatMessage(
        id: e.id,
        text: e.content,
        user: ChatUser(
          uid: e.from,
        )
      );

      if(e.type == EnumToString.convertToString(MessageType.IMAGE)){
        message.image = '$CHAT_PUBLIC_URL/${message.text}';
        message.text = '';
      } else if(e.type == EnumToString.convertToString(MessageType.LOCATION)){
        message.image = '';
      }

      return message;
    }));

    _socket.on('private message', (data) async {
      final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);

      if(_destinationID == response.to){
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

        // final result = await _chatUserDB.addMessage(response);
        // if(result > 0){
        //   messages.add(newMessage);
        //   messages.refresh();
        //   _mainController.addMessage(response.from, response);
        // }

        messages.add(newMessage);
        messages.refresh();
      }
    });
  }

  Future sendStringMessage(ChatMessage newMessage) async {
    if(newMessage.text == null || newMessage.text!.isEmpty){
      return;
    }

    final newSocketMessage = ChatSocketMessage(
      id: const Uuid().v4(),
      content: newMessage.text!,
      from: _localStorage.getUserID()!,
      to: _destinationID,
      type: EnumToString.convertToString(MessageType.STRING),
    );

    _socket.emitWithAck('private message', newSocketMessage, ack: (data) {
      if(data != null){
        final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);

        _sendMessage(response, newMessage);
      }
    });

  }

  Future sendImageMessage(String base64Image) async {
    final newSocketMessage = ChatSocketMessage(
      id: const Uuid().v4(),
      content: base64Image,
      from: _localStorage.getUserID()!,
      to: _destinationID,
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

        _sendMessage(response, newMessage);
      }
    });
  }

  Future sendLocationMessage() async {

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
      id: const Uuid().v4(),
      content: '${_locationData.latitude},${_locationData.longitude}',
      from: _localStorage.getUserID()!,
      to: _destinationID,
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

        _sendMessage(response, newMessage);
      }
    });
  }

  Future _sendMessage(ChatSocketMessage socketMessage, ChatMessage chatMessage) async {
    final result = await _chatUserDB.addMessage(socketMessage);

    if(result > 0){
      messages.add(chatMessage);
      messages.refresh();
      _mainController.addMessage(_destinationID, socketMessage);
    }
  }
}