import 'package:eztour_traveller/Screens/Main/main_screen.dart';
import 'package:eztour_traveller/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:eztour_traveller/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: MainScreen(),
      home: LoginScreen(),
    );
  }
}
