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

  void listenNotifications() => selectNotificationSubject.stream.listen(onClickedNotification);

  @override
  void initState() {
    super.initState();

    initNotification();

    listenNotifications();

    Future.microtask(() => loadData());
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 1), onDoneLoading);
  }

  Future onDoneLoading() async {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      // return LoginScreen();
      return const MainScreen();
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text('Eztour Splash Screen'),
        ),
      ),
    );
  }
}
