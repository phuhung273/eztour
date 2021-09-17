

import 'package:eztour_traveller/chat/chat_api.dart';
import 'package:eztour_traveller/datasource/local/local_storage.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:get/get.dart';

class MainScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}

class MainScreenController extends GetxController{
  final LocalStorage _localStorage = Get.find();

  var pageIndex = 0.obs;


  @override
  void onInit() {
    super.onInit();

    initChat();
  }

  void changeTab(int value) {
    pageIndex.value = value;
  }

  void logOut(){
    _localStorage.removeAccessToken();
    Get.offAndToNamed(ROUTE_LOGIN);
  }
}