import 'package:eztour_traveller/di/di.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/screens/splash/splash_screen_controller.dart';
import 'package:eztour_traveller/theme.dart';
import 'package:flutter/material.dart';
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
      theme: appTheme,
      initialBinding: SplashScreenBinding(),
      initialRoute: ROUTE_SPLASH,
      getPages: appRoute,
      defaultTransition: Transition.fade,
      transitionDuration: Get.defaultTransitionDuration,
    );
  }
}


