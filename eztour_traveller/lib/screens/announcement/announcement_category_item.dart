import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementCategoryItem extends StatelessWidget {
  final String title;
  final List<Announcement> announcements;

  const AnnouncementCategoryItem({
    required this.title,
    required this.announcements,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.headline4,
              ),
            ),
            const Icon(
              Icons.more_horiz
            )
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final item = announcements[index];

            return ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                height: double.infinity,
                child: Icon(
                  Icons.radio_button_unchecked,
                  size: theme.textTheme.bodyText1!.fontSize,
                ),
              ),
              title: Text(
                item.message,
                style: theme.textTheme.bodyText1,
              ),
            );
          },
        )
      ],
    );
  }
}
