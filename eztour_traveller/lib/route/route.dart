
import 'package:eztour_traveller/screens/Login/login_screen.dart';
import 'package:eztour_traveller/screens/Login/login_screen_controller.dart';
import 'package:eztour_traveller/screens/Main/main_screen.dart';
import 'package:eztour_traveller/screens/Main/main_screen_controller.dart';
import 'package:eztour_traveller/screens/Message/message_screen.dart';
import 'package:eztour_traveller/screens/Message/message_screen_controller.dart';
import 'package:eztour_traveller/screens/Splash/splash_screen.dart';
import 'package:eztour_traveller/screens/Splash/splash_screen_controller.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const ROUTE_SPLASH = '/splash';
const ROUTE_LOGIN = '/login';
const ROUTE_MAIN = '/main';
const ROUTE_MESSAGE = '/message';

var appRoute = [
  GetPage(name: ROUTE_SPLASH, page: () => SplashScreen(), binding: SplashScreenBinding()),
  GetPage(name: ROUTE_LOGIN, page: () => LoginScreen(), binding: LoginScreenBinding()),
  GetPage(name: ROUTE_MAIN, page: () => MainScreen(), binding: MainScreenBinding()),
  GetPage(name: ROUTE_MESSAGE, page: () => MessageScreen(), binding: MessageScreenBinding()),
];
