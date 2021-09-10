import 'package:dash_chat/dash_chat.dart';
import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

class MessageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageScreenController());
  }
}

class MessageScreenController extends GetxController {

  var messages = List<ChatMessage>.empty().obs;

  final Socket _socket = Get.find();
  final LocalStorage _localStorage = Get.find();

  final String _destinationID = Get.arguments as String;

  final ChatUserDB _chatUserDB = Get.find();

  final ScrollController scrollController = ScrollController();

  @override
  Future onInit() async {
    super.onInit();

    final savedMessages = await _chatUserDB.getMessagesByPartnerID(_destinationID);

    messages.assignAll(savedMessages.map((e) => ChatMessage(
      id: e.id,
      text: e.content,
      user: ChatUser(
        uid: e.from,
      )
    )));
    _scrollToBottom();

    _socket.on('private message', (data) {
      final response = ChatSocketMessage.fromJson(data as Map<String, dynamic>);
      final newMessage = ChatMessage(
        id: response.id,
        text: response.content,
        user: ChatUser(
          uid: response.from,
        ),
      );

      _chatUserDB.addMessage(response);
      messages.add(newMessage);
      _scrollToBottom();
    });
  }

  Future sendMessage(ChatMessage newMessage) async {
    final newSocketMessage = ChatSocketMessage(
      id: const Uuid().v4(),
      content: newMessage.text!,
      from: _localStorage.getUserID()!,
      to: _destinationID,
    );
    _socket.emit('private message', newSocketMessage);

    final result = await _chatUserDB.addMessage(newSocketMessage);
    if(result > 0){
      messages.add(newMessage);
      _scrollToBottom();
    }
  }

  void _scrollToBottom(){
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}