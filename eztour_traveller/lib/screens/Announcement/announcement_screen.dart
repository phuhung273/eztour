
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/screens/Announcement/announcement_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementScreen extends StatelessWidget {

  final AnnouncementScreenController _controller = Get.put(AnnouncementScreenController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Announcement",
            style: TextStyle(fontSize: 25.0),
          ),
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: _controller.announcements.length,
              itemBuilder: (BuildContext context, int index) {

                final announcement = _controller.announcements[index];

                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child:  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    title: Text(announcement.message, style: const TextStyle(fontSize: 20)),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          )
        ],
      ),
    );
  }
}
