
import 'package:eztour_traveller/mixins/swipeable.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class ChecklistTile extends StatelessWidget with Swipeable {
  final Todo todo;
  final VoidCallback onTap;
  final Function onDelete;
  final Function onUpdate;

  const ChecklistTile({
    Key? key,
    required this.todo,
    required this.onTap,
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
          leading: _buildCheckIcon(todo.isDone()),
          minLeadingWidth: 0,
          title: Text(
            todo.message,
            style: theme.textTheme.bodyText1,
          ),
          onTap: onTap
      ),
    );
  }

  Widget _buildCheckIcon(bool done){
    return done ? const Icon(Icons.check_circle, color: Colors.green)
        : const Icon(Icons.radio_button_unchecked, color: Colors.black);
  }
}