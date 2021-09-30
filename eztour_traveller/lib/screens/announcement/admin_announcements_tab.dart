import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'announcement_category_item.dart';
import 'announcement_screen_controller.dart';

class AdminAnnouncementsTab extends GetView<AnnouncementScreenController> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultSpacing),
            child: Obx(
              () => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories.keys.elementAt(index);

                  return AnnouncementCategoryItem(
                    title: category,
                    announcements: controller.categories[category]!,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}