
import 'package:dash_chat/dash_chat.dart';
import 'package:eztour_traveller/screens/Message/message_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MessageScreen extends StatelessWidget {

  final MessageScreenController _controller = Get.find();

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    uid: "123456789",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message Screen"),
      ),
      body: Obx(
        () => DashChat(
          key: _chatViewKey,
          messages: _controller.messages.isEmpty ? [] : _controller.messages.value,
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
          onSend: _controller.sendMessage,
        ),
      ),
    );
  }
}
