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

  final MainScreenController _controller = Get.find();

  MainScreen({
    this.payload,
    Key? key,
  }) : super(key: key);

  final String? payload;

  // @override
  // void initState() {
  //
  //   if(widget.payload != null){
  //     setState(() {
  //       _pageIndex = 2;
  //     });
  //   }
  //
  //   super.initState();
  //
  // }


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
            child:  _buildTab(_controller.pageIndex.value),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _controller.pageIndex.value,
        onTap: (value) {
          _controller.changeTab(value);
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

  Widget _buildTab(int index){
    switch(index){
      case 0:
        return HomeScreen();

      case 1:
        // return ScheduleDetail();
        return ScheduleScreen();

      case 2:
        return AnnouncementScreen();

      case 3:
        return ChecklistScreen();

      case 4:
        return ChatScreen();

      default:
        return HomeScreen();
    }
  }
}
