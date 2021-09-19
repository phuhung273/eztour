
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementCard({
    Key? key,
    required this.announcements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Limit to 3 items only
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: announcements.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child:  ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Text(announcements[index].message, style: const TextStyle(fontSize: 20)),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
      ],
    );
  }
}
