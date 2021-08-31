
import 'package:get/get.dart';

class MainScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}

class MainScreenController extends GetxController{
  var pageIndex = 0.obs;

  void changeTab(int value) {
    pageIndex.value = value;
    update();
  }
}