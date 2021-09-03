
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/screens/Checklist/checklist_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChecklistScreen extends StatelessWidget {

  final ChecklistScreenController _controller = Get.put(ChecklistScreenController());

  Widget _buildCheckIcon(bool done){
    return done ? const Icon(Icons.check_circle, color: Colors.green, size: 32)
        : const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 32);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Checklist",
            style: TextStyle(fontSize: 25.0),
          ),
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: _controller.todos.length,
              itemBuilder: (BuildContext context, int index) {

                final todo = _controller.todos[index];

                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child:  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    title: Text(todo.message, style: const TextStyle(fontSize: 20)),
                    trailing: IconButton(
                      icon: _buildCheckIcon(todo.done),
                      onPressed: () => _controller.toggleTodo(index),
                    ),
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
