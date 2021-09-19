
import 'package:eztour_traveller/screens/checklist/checklist_detail_screen.dart';
import 'package:eztour_traveller/screens/login/login_screen.dart';
import 'package:eztour_traveller/screens/login/login_screen_controller.dart';
import 'package:eztour_traveller/screens/main/main_screen.dart';
import 'package:eztour_traveller/screens/main/main_screen_controller.dart';
import 'package:eztour_traveller/screens/message/message_screen.dart';
import 'package:eztour_traveller/screens/message/message_screen_controller.dart';
import 'package:eztour_traveller/screens/splash/splash_screen.dart';
import 'package:eztour_traveller/screens/splash/splash_screen_controller.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const ROUTE_SPLASH = '/splash';
const ROUTE_LOGIN = '/login';
const ROUTE_MAIN = '/main';
const ROUTE_MESSAGE = '/message';
const ROUTE_CHECKLIST_DETAIL = '/checklist_detail';

var appRoute = [
  GetPage(name: ROUTE_SPLASH, page: () => SplashScreen(), binding: SplashScreenBinding()),
  GetPage(name: ROUTE_LOGIN, page: () => LoginScreen(), binding: LoginScreenBinding()),
  GetPage(name: ROUTE_MAIN, page: () => MainScreen(), binding: MainScreenBinding()),
  GetPage(name: ROUTE_MESSAGE, page: () => MessageScreen(), binding: MessageScreenBinding()),
  GetPage(name: ROUTE_CHECKLIST_DETAIL, page: () => ChecklistDetailScreen()),
];
