import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/enum.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'announcement_category_item.dart';
import 'announcement_screen_controller.dart';

class MyAnnouncementsTab extends GetView<AnnouncementScreenController> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(defaultSpacing),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                TextButton.icon(
                  onPressed: () => Get.toNamed(
                      ROUTE_MY_ANNOUNCEMENTS,
                      parameters: {
                        modeParams: EnumToString.convertToString(Mode.Add),
                      }
                  ),
                  icon: Icon(Icons.add, color: theme.colorScheme.onSurface),
                  label: Text(
                    'Add notes',
                    style: theme.textTheme.button!.copyWith(
                        color: theme.colorScheme.onSurface
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.myCategories.length,
                itemBuilder: (context, index) {
                  final category = controller.myCategories.keys.elementAt(index);

                  return InkWell(
                    onTap: () => Get.toNamed(
                        ROUTE_MY_ANNOUNCEMENTS,
                        parameters: {
                          categoryParams: category,
                          modeParams: EnumToString.convertToString(Mode.Edit),
                        }
                    ),
                    child: AnnouncementCategoryItem(
                      title: category,
                      announcements: controller.myCategories[category]!,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}