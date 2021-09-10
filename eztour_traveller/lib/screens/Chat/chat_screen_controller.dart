import 'package:eztour_traveller/datasource/local/chat_user_db.dart';
import 'package:eztour_traveller/schema/chat/chat_socket_user.dart';
import 'package:eztour_traveller/schema/chat/chat_user_disconnected_response.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatScreenController());
  }
}

class ChatScreenController extends GetxController {
  final ChatUserDB chatUserDB = Get.find();

  final Socket _socket = Get.find();

  final users = List<ChatSocketUser>.empty().obs;

  @override
  Future onInit() async {
    super.onInit();

    users.value = await chatUserDB.getUsers();

    _socket.on('user connected', (data){
      final response = ChatSocketUser.fromJson(data as Map<String, dynamic>);

      final selectedIndex = users.indexWhere((element) => element.userID == response.userID);
      users[selectedIndex].connected = 1;
      users.refresh();
    });

    _socket.on('user disconnected', (data){
      final response = ChatUserDisconnectedResponse.fromJson(data as Map<String, dynamic>);

      final selectedIndex = users.indexWhere((element) => element.userID == response.userID);
      users[selectedIndex].connected = 0;
      users.refresh();
    });
  }
}