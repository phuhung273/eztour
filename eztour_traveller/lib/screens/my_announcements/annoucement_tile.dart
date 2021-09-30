
import 'package:eztour_traveller/mixins/swipeable.dart';
import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class AnnouncementTile extends StatelessWidget with Swipeable {
  final Announcement item;
  final Function onDelete;
  final Function onUpdate;

  const AnnouncementTile({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwipeActionCell(
      key: UniqueKey(),
      trailingActions: [
        SwipeAction(
          ///you should set the default  bg color to transparent
            color: Colors.transparent,

            ///set content instead of title of icon
            content: buildIconButton(Colors.red, Icons.delete),
            onTap: (handler) async {
              await handler(true);
              onDelete();
            }
        ),
        SwipeAction(
          ///you should set the default  bg color to transparent
            color: Colors.transparent,

            ///set content instead of title of icon
            content: buildIconButton(Colors.green, Icons.edit),
            onTap: (handler) {
              handler(false);
              onUpdate();
            }
        ),
      ],
      child: ListTile(
          minLeadingWidth: 0,
          title: Text(
            item.message,
            style: theme.textTheme.bodyText1,
          ),
      ),
    );
  }
}