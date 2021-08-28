import 'dart:async';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

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
  var m = <ChatMessage>[];

  var i = 0;

  void _systemMessage() {
    Timer(const Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(const Duration(milliseconds: 300), () {
        _chatViewKey.currentState!.scrollController
          .animateTo(
            _chatViewKey
                .currentState!.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void _onSend(ChatMessage message) {
    setState(() {
      messages = [...messages, message];
      print(messages.length);
    });

    if (i == 0) {
      _systemMessage();
      Timer(const Duration(milliseconds: 600), () {
        _systemMessage();
      });
    } else {
      _systemMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message Screen"),
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
