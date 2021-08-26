import 'dart:async';

import 'package:eztour_traveller/notifications/notification_api.dart';
import 'package:eztour_traveller/screens/Login/login_screen.dart';
import 'package:eztour_traveller/screens/Main/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void onClickedNotification(String? payload) {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return MainScreen(payload: payload);
    }));
  }

  void listenNotifications() => NotificationApi.selectNotificationSubject.stream.listen(onClickedNotification);

  @override
  void initState() {
    super.initState();

    NotificationApi.init();

    listenNotifications();

    Future.microtask(() => loadData());
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 1), onDoneLoading);
  }

  void onDoneLoading() async {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      // return LoginScreen();
      return MainScreen();
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Eztour Splash Screen'),
        ),
      ),
    );
  }
}
