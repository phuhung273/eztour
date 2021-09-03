import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/chat/chat.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:eztour_traveller/screens/Chat/chat_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_card.dart';

class ChatScreen extends StatelessWidget {

  final ChatScreenController _controller = Get.put(ChatScreenController());

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
              _buildTravelCompanions(),
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
                  press: () => _goToMessageScreen('abc'),
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
        _buildRecentMessages()
      ],
    );
  }

  Widget _buildRecentMessages() {
    return Obx(
      () => SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final chatSocketUser = _controller.users[index];
            final chat = Chat(
              name: chatSocketUser.username,
              isActive: chatSocketUser.connected == 1,
              image: 'user.jpg',
              time: '8m ago',
              lastMessage: 'hello world',
            );

            return ChatCard(
              chat: chat,
              press: () => _goToMessageScreen(chatSocketUser.userID),
            );
          },
          childCount: _controller.users.length,
        ),
      ),
    );
  }

  Widget _buildTravelCompanions() {
    return Padding(
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
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.only(left: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: _controller.users.length,
                itemBuilder: (BuildContext context, int index) {
                  final chatSocketUser = _controller.users[index];
                  final chat = Chat(
                    name: chatSocketUser.username,
                    isActive: chatSocketUser.connected == 1,
                    image: 'user.jpg',
                    time: '8m ago',
                    lastMessage: 'hello world',
                  );

                  return InkWell(
                    onTap: () => _goToMessageScreen(chatSocketUser.userID),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                            AssetImage(chat.image),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            chat.name,
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
          ),
        ],
      ),
    );
  }

  void _goToMessageScreen(String id){
    Get.toNamed(ROUTE_MESSAGE, arguments: id);
  }
}
