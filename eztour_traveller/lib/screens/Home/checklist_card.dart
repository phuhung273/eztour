
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:flutter/material.dart';

class ChecklistCard extends StatelessWidget {
  final List<Todo> todos;

  const ChecklistCard({
    Key? key,
    required this.todos,
  }) : super(key: key);

  Widget _buildCheckIcon(bool done){
    return done ? const Icon(Icons.check_circle, color: Colors.green, size: 32)
        : const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 32);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Limit to 3 items only
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child:  ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Text(todos[index].message, style: const TextStyle(fontSize: 20)),
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
