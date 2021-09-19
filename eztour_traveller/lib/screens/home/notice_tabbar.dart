import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/checklist/todo_category.dart';
import 'package:flutter/material.dart';

import 'announcement_card.dart';
import 'checklist_tab.dart';

class NoticeTabBar extends StatelessWidget {
  final List<Announcement> announcements;
  final List<TodoCategory> todoCategories;

  const NoticeTabBar({
    Key? key,
    required this.todoCategories,
    required this.announcements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: pillBorderRadius,
            ),
            child: TabBar(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
              tabs: [
                Tab(
                  child: Text(
                    'checklist',
                    style: _getTabTitleStyle(theme),
                  ),
                ),
                Tab(
                  child: Text(
                    'Announcements',
                    style: _getTabTitleStyle(theme),
                  ),
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: pillBorderRadius,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Container(
            height: 450.0,
            margin: const EdgeInsets.only(top: defaultSpacing),
            child: TabBarView(
              children: [
                ChecklistTab(todoCategories: todoCategories),
                AnnouncementCard(announcements: announcements),
              ]
            ),
          ),
        ],
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
