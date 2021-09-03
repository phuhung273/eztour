
import 'package:get_storage/get_storage.dart';

const CHAT_SESSIONID_KEY = 'CHAT_SESSIONID_KEY';
const ACCESSTOKEN_KEY = 'ACCESSTOKEN_KEY';
const USERID_KEY = 'USERID_KEY';
const USERNAME_KEY = 'USERNAME_KEY';
const DEVICENAME_KEY = 'DEVICENAME_KEY';

class LocalStorage {
  final box = GetStorage();

  void saveChatSessionID(String value) {
    box.write(CHAT_SESSIONID_KEY, value);
  }

  String? getChatSessionID() {
    return box.read(CHAT_SESSIONID_KEY);
  }

  void saveAccessToken(String value){
    box.write(ACCESSTOKEN_KEY, value);
  }

  String? getAccessToken() {
    return box.read(ACCESSTOKEN_KEY);
  }

  void saveUsername(String value){
    box.write(USERNAME_KEY, value);
  }

  String? getUsername() {
    return box.read(USERNAME_KEY);
  }

  void saveUserID(String value){
    box.write(USERID_KEY, value);
  }

  String? getUserID() {
    return box.read(USERID_KEY);
  }

  void saveDeviceName(String value){
    box.write(DEVICENAME_KEY, value);
  }

  String? getDeviceName() {
    return box.read(DEVICENAME_KEY);
  }

}