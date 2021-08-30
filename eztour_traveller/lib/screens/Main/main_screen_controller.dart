
import 'package:eztour_traveller/screens/Announcement/announcement_screen.dart';
import 'package:eztour_traveller/screens/Chat/chat_screen.dart';
import 'package:eztour_traveller/screens/Checklist/checklist_screen.dart';
import 'package:eztour_traveller/screens/Home/home_screen.dart';
import 'package:eztour_traveller/screens/ScheduleDetail/schedule_detail.dart';
import 'package:flutter/material.dart';
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