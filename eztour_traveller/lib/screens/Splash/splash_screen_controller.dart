
import 'dart:async';

import 'package:eztour_traveller/notifications/notification_api.dart';
import 'package:eztour_traveller/screens/Main/main_screen.dart';
import 'package:eztour_traveller/screens/route/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }

}

class SplashScreenController extends GetxController{

  void _onClickedNotification(String? payload) {
    Get.off(() => MainScreen(payload: payload));
  }

  void _listenNotifications() => selectNotificationSubject.stream.listen(_onClickedNotification);

  Future<Timer> _loadData() async {
    return Timer(const Duration(seconds: 1), _onDoneLoading);
  }

  Future _onDoneLoading() async {
    Get.offAndToNamed(ROUTE_MAIN);
  }

  @override
  void onInit() {
    super.onInit();

    initNotification();

    _listenNotifications();

    Future.microtask(() => _loadData());
  }
}