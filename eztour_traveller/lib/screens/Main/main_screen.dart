import 'package:animations/animations.dart';
import 'package:eztour_traveller/Screens/Home/home_screen.dart';
import 'package:eztour_traveller/Screens/Schedule/schedule_screen.dart';
import 'package:eztour_traveller/chat/chat_api.dart';
import 'package:eztour_traveller/screens/Announcement/announcement_screen.dart';
import 'package:eztour_traveller/screens/Chat/chat_screen.dart';
import 'package:eztour_traveller/screens/Checklist/checklist_screen.dart';
import 'package:eztour_traveller/screens/Main/main_screen_controller.dart';
import 'package:eztour_traveller/screens/ScheduleDetail/schedule_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {

  final MainScreenController controller = Get.find();

  MainScreen({
    this.payload,
    Key? key,
  }) : super(key: key);

  final String? payload;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const ScheduleDetail(),
    // const ScheduleScreen(),
    const AnnouncementScreen(),
    const ChecklistScreen(),
    const ChatScreen(),
  ];

  // @override
  // void initState() {
  //
  //   if(widget.payload != null){
  //     setState(() {
  //       _pageIndex = 2;
  //     });
  //   }
  //   initChat("admin");
  //
  //   super.initState();
  //
  // }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.pageIndex.value,
        onTap: (value) {
          controller.changeTab(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Schedule"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Announcement"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_rounded), label: "Checklist"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Chat"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation)=>
                FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                ),
            child:  _tabs[controller.pageIndex.value],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
