import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  final List<Todo> todos;
  final String title;
  final Color color;

  const ChecklistCard({
    Key? key,
    required this.title,
    required this.todos,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: roundedRectangleShape,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 2),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.7),
                color,
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: defaultSpacing),
              child: Text(
                title,
                style: theme.textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: todos.length,
              itemBuilder: (context, index) => ChecklistItem(todo: todos[index]),
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}

class ChecklistItem extends StatelessWidget {
  const ChecklistItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: defaultPadding),
          child: _buildCheckIcon(todo.isDone(), theme.textTheme.bodyText1!.fontSize!),
        ),
        Expanded(
          child: Text(
            todo.message,
            style: theme.textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckIcon(bool done, double size){
    return done ? Icon(Icons.check_circle, color: Colors.white, size: size)
        : Icon(Icons.radio_button_unchecked, color: Colors.white, size: size);
  }
}