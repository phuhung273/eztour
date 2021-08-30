
import 'package:eztour_traveller/screens/Main/main_screen.dart';
import 'package:eztour_traveller/screens/Main/main_screen_controller.dart';
import 'package:eztour_traveller/screens/Splash/splash_screen.dart';
import 'package:eztour_traveller/screens/Splash/splash_screen_controller.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const ROUTE_SPLASH = '/splash';
const ROUTE_MAIN = '/main';

var appRoute = [
  GetPage(name: ROUTE_SPLASH, page: () => SplashScreen(), binding: SplashScreenBinding()),
  GetPage(name: ROUTE_MAIN, page: () => MainScreen(), binding: MainScreenBinding()),
];
