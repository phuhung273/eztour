import 'package:dash_chat/dash_chat.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

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

  @override
  void onInit() {
    super.onInit();

    _socket.on('private message', (data) {
      final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);
      final newMessage = ChatMessage(
        text: response.content,
        user: ChatUser(
          uid: response.from,
        ),
      );

      messages.add(newMessage);
      update();
    });
  }

  void sendMessage(ChatMessage newMessage){
    final newSocketMessage = ChatSocketMessage(
      content: newMessage.text,
      from: _localStorage.getUserID(),
      to: _destinationID,
    );
    _socket.emit('private message', newSocketMessage);
    messages.add(newMessage);
    update();
  }
}