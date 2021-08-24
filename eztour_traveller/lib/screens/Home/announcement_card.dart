
import 'package:eztour_traveller/schema/announcement/todo.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final List<Todo> todos;

  const AnnouncementCard({
    Key? key,
    required this.todos,
  }) : super(key: key);

  Widget _buildCheckIcon(bool done){
    return done ? Icon(Icons.check_circle, color: Colors.green, size: 32)
        : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 32);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Checklist",
          style: TextStyle(fontSize: 25.0),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child:  ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Text(todos[index].message, style: TextStyle(fontSize: 20)),
                trailing: _buildCheckIcon(todos[index].done),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
      ],
    );
  }
}
