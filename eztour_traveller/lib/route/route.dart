
import 'package:eztour_traveller/screens/checklist/checklist_detail_screen.dart';
import 'package:eztour_traveller/screens/login/login_screen.dart';
import 'package:eztour_traveller/screens/login/login_screen_controller.dart';
import 'package:eztour_traveller/screens/main/main_screen.dart';
import 'package:eztour_traveller/screens/main/main_screen_controller.dart';
import 'package:eztour_traveller/screens/message/message_screen.dart';
import 'package:eztour_traveller/screens/message/message_screen_controller.dart';
import 'package:eztour_traveller/screens/my_announcements/my_announcements_controller.dart';
import 'package:eztour_traveller/screens/my_announcements/my_announcements_screen.dart';
import 'package:eztour_traveller/screens/my_checklist/my_checklist_controller.dart';
import 'package:eztour_traveller/screens/my_checklist/my_checklist_screen.dart';
import 'package:eztour_traveller/screens/splash/splash_screen.dart';
import 'package:eztour_traveller/screens/splash/splash_screen_controller.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const ROUTE_SPLASH = '/splash';
const ROUTE_LOGIN = '/login';
const ROUTE_MAIN = '/main';
const ROUTE_MESSAGE = '/message';
const ROUTE_CHECKLIST_DETAIL = '/checklist_detail';
const ROUTE_MY_CHECKLIST = '/my_checklist';
const ROUTE_MY_ANNOUNCEMENTS = '/my_announcements';

var appRoute = [
  GetPage(name: ROUTE_SPLASH, page: () => SplashScreen(), binding: SplashScreenBinding()),
  GetPage(name: ROUTE_LOGIN, page: () => LoginScreen(), binding: LoginScreenBinding()),
  GetPage(name: ROUTE_MAIN, page: () => MainScreen(), binding: MainScreenBinding()),
  GetPage(name: ROUTE_MESSAGE, page: () => MessageScreen(), binding: MessageScreenBinding()),
  GetPage(name: ROUTE_CHECKLIST_DETAIL, page: () => ChecklistDetailScreen()),
  GetPage(name: ROUTE_MY_CHECKLIST, page: () => MyChecklistScreen(), binding: MyChecklistScreenBinding()),
  GetPage(name: ROUTE_MY_ANNOUNCEMENTS, page: () => MyAnnouncementScreen(), binding: MyAnnouncementScreenBinding()),
];
