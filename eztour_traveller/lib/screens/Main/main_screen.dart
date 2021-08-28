import 'package:animations/animations.dart';
import 'package:eztour_traveller/Screens/Home/home_screen.dart';
import 'package:eztour_traveller/Screens/Schedule/schedule_screen.dart';
import 'package:eztour_traveller/screens/Announcement/announcement_screen.dart';
import 'package:eztour_traveller/screens/Chat/chat_screen.dart';
import 'package:eztour_traveller/screens/Checklist/checklist_screen.dart';
import 'package:eztour_traveller/screens/ScheduleDetail/schedule_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    this.payload,
    Key? key,
  }) : super(key: key);

  final String? payload;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> pageList = [
    const HomeScreen(),
    const ScheduleDetail(),
    // const ScheduleScreen(),
    const AnnouncementScreen(),
    const ChecklistScreen(),
    const ChatScreen(),
  ];

  int _pageIndex = 4;

  @override
  void initState() {
    if(widget.payload != null){
      setState(() {
        _pageIndex = 2;
      });
    }

    super.initState();
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _pageIndex,
      onTap: (value) {
        setState(() {
          _pageIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: "Schedule"),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Announcement"),
        BottomNavigationBarItem(icon: Icon(Icons.check_circle_rounded), label: "Checklist"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Chat"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation)=>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
              ),
            child: pageList[_pageIndex]
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
