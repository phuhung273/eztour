
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/widgets/colored_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_announcements_tab.dart';
import 'announcement_screen_controller.dart';
import 'my_announcements_tab.dart';

class AnnouncementScreen extends StatelessWidget {

  final AnnouncementScreenController _controller = Get.put(AnnouncementScreenController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: const Text('Announcements'),
          bottom: ColoredTabBar(
            color: Colors.white,
            tabBar: TabBar(
              padding: const EdgeInsets.symmetric(vertical: defaultSpacing, horizontal: defaultSpacing),
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: thinRoundedRectangleBorderRadius,
                color: Colors.black,
              ),
              tabs: [
                Tab(
                  child: Text(
                    'From tour guide',
                    style: _getTabTitleStyle(theme),
                  ),
                ),
                Tab(
                  child: Text(
                    'Your notes',
                    style: _getTabTitleStyle(theme),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AdminAnnouncementsTab(),
            MyAnnouncementsTab(),
          ],
        ),
      ),
    );
  }

  TextStyle _getTabTitleStyle(ThemeData theme){
    final style = theme.textTheme.bodyText1!;
    return TextStyle(
        fontFamily: style.fontFamily,
        fontSize: style.fontSize,
        fontWeight: style.fontWeight
    );
  }
}
