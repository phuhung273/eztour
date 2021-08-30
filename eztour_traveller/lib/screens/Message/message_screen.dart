import 'dart:async';

import 'package:dash_chat/dash_chat.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    uid: "123456789",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );

  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatMessage> m = <ChatMessage>[];

  int i = 0;

  final Socket _socket = Get.find();


  @override
  void initState() {
    super.initState();

    _socket.on('private message', (data) {
      final response = ChatSocketMessage.fromJson(data);
      final newMessage = ChatMessage(
        text: response.content,
        user: ChatUser(
          uid: response.from,
        ),
      );

      setState(() {
        messages = [...messages, newMessage];
      });
    });
  }

  void _onSend(ChatMessage message) {
    setState(() {
      messages = [...messages, message];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message Screen"),
      ),
      body: DashChat(
        key: _chatViewKey,
        messages: messages,
        user: user,
        inputDecoration: const InputDecoration.collapsed(hintText: "Add message here..."),
        dateFormat: DateFormat('yyyy-MMM-dd'),
        timeFormat: DateFormat('HH:mm'),
        messageContainerPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
        inputTextStyle: const TextStyle(fontSize: 16.0),
        inputContainerStyle: BoxDecoration(
          border: Border.all(width: 0.0),
          color: Colors.white,
        ),
        trailing: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () async {

            },
          )
        ],
        onSend: _onSend,
      ),
    );
  }
}
