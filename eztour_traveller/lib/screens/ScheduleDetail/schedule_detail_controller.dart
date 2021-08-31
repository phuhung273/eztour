import 'package:get/get.dart';

class ScheduleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleDetailController());
  }
}

class ScheduleDetailController extends GetxController {
  var day = 0.obs;
}