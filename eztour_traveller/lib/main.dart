import 'package:eztour_traveller/di/di.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/screens/Splash/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:get/get.dart';

Future main() async {
  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: SplashScreenBinding(),
      initialRoute: ROUTE_SPLASH,
      getPages: appRoute
    );
  }
}


