import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:eztour_traveller/Screens/Home/home_screen.dart';
import 'package:eztour_traveller/screens/Announcement/announcement_screen.dart';
import 'package:eztour_traveller/screens/Chat/chat_screen.dart';
import 'package:eztour_traveller/screens/Checklist/checklist_screen.dart';
import 'package:eztour_traveller/screens/Main/main_screen_controller.dart';
import 'package:eztour_traveller/screens/Schedule/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const scheduleScreenIndex = 4;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.changeTab(scheduleScreenIndex),
        child: const Icon(Icons.event),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTab(int index){
    switch(index){
      case 0:
        return HomeScreen();

      case 1:
        return AnnouncementScreen();

      case 2:
        return ChecklistScreen();

      case 3:
        return ChatScreen();

      case 4:
        return ScheduleScreen();

      default:
        return HomeScreen();
    }
  }
}

class _buildBottomNavigationBar extends StatelessWidget {
  final MainScreenController _controller = Get.find();

  _buildBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.notifications,
          Icons.check_circle_rounded,
          Icons.chat_outlined,
        ],
        activeIndex: _controller.pageIndex.value,
        gapLocation: GapLocation.center,
        onTap: (index) => _controller.changeTab(index),
        backgroundColor: theme.primaryColor,
        activeColor: theme.colorScheme.onPrimary,
        inactiveColor: theme.colorScheme.onPrimary,
        //other params
      )
    );
  }
}

