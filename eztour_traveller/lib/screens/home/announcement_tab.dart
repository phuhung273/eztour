import 'dart:math';

import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/announcement/announcement_category.dart';
import 'package:flutter/material.dart';

const ANNOUNCEMENT_LIMIT = 3;

class AnnouncementTab extends StatelessWidget {
  final List<AnnouncementCategory> categories;

  const AnnouncementTab({
    required this.categories,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(ANNOUNCEMENT_LIMIT, categories.length),
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
        return AnnouncementCard(
          title: category.name,
          items: category.announcements,
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String title;
  final List<Announcement> items;

  const AnnouncementCard({
    Key? key,
    required this.items,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headline6,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: min(3, items.length),
              itemBuilder: (BuildContext context, int index) {
                return Text(items[index].message, style: const TextStyle(fontSize: 20));
              },
            ),
          ],
        ),
      ),
    );
  }
}