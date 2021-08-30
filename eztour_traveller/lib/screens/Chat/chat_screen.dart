import 'package:eztour_traveller/schema/chat/chat.dart';
import 'package:eztour_traveller/screens/Message/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<Chat> _chats = [
    Chat(
      name: "Jenny Wilson",
      lastMessage: "Hope you are doing well...",
      image: "assets/images/user.png",
      time: "3m ago",
      isActive: false,
    ),
    Chat(
      name: "Esther Howard",
      lastMessage: "Hello Abdullah! I am...",
      image: "assets/images/user_2.png",
      time: "8m ago",
      isActive: true,
    ),
    Chat(
      name: "Ralph Edwards",
      lastMessage: "Do you have update...",
      image: "assets/images/user_3.png",
      time: "5d ago",
      isActive: false,
    ),
    Chat(
      name: "Jacob Jones",
      lastMessage: "You’re welcome :)",
      image: "assets/images/user_4.png",
      time: "5d ago",
      isActive: true,
    ),
    Chat(
      name: "Albert Flores",
      lastMessage: "Thanks",
      image: "assets/images/user_5.png",
      time: "6d ago",
      isActive: false,
    ),
    Chat(
      name: "Jenny Wilson",
      lastMessage: "Hope you are doing well...",
      image: "assets/images/user.png",
      time: "3m ago",
      isActive: false,
    ),
    Chat(
      name: "Esther Howard",
      lastMessage: "Hello Abdullah! I am...",
      image: "assets/images/user_2.png",
      time: "8m ago",
      isActive: true,
    ),
    Chat(
      name: "Ralph Edwards",
      lastMessage: "Do you have update...",
      image: "assets/images/user_3.png",
      time: "5d ago",
      isActive: false,
    ),
  ];

  void _goToMessageScreen(){
    Get.to(const MessageScreen());
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          automaticallyImplyLeading: false,
          title: const Text('Chats'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: (){},
            )
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Yours travel companions',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: _chats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: _goToMessageScreen,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage:
                                    AssetImage(_chats[index].image),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    _chats[index].name,
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: const Text(
                        'Text with admin',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ]
              ),
              ChatCard(
                  chat: Chat(
                    name: "Administrator",
                    lastMessage: "Hello Abdullah! I am...",
                    image: "assets/images/user_2.png",
                    time: "8m ago",
                    isActive: true,
                  ),
                  press: _goToMessageScreen,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: const Text(
                      'Recent messages',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ]
              ),
            ]
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) =>
            ChatCard(
                chat: _chats[index],
                press: _goToMessageScreen,
            ),
            childCount: _chats.length,
          ),
        )
      ],
    );
  }
}
