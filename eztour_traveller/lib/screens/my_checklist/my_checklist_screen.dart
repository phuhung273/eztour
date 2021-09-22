import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/widgets/keyboard_friendly_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'checklist_tile.dart';
import 'my_checklist_bottomsheet.dart';
import 'my_checklist_controller.dart';

class MyChecklistScreen extends StatelessWidget {

  final MyChecklistScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleHinText = _controller.category.isEmpty ? 'Title' : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your checklist'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.submit();
              Get.back();
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: KeyboardFriendlyBody(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: theme.colorScheme.surface,
                  filled: true,
                  hintText: titleHinText,
                ),
                controller: _controller.titleController,
                onChanged: (value) => _controller.category = value,
              ),
              const Divider(),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.todos.length,
                  itemBuilder: (context, index){
                    final todo = _controller.todos[index];

                    return ChecklistTile(
                      todo: todo,
                      onTap: () => _controller.toggle(index),
                      onDelete: () => _controller.deleteAt(index),
                      onUpdate: () => Get.bottomSheet(
                          MyChecklistBottomSheet(
                            initialMessage: todo.message,
                            onSave: (message) async {
                              if(message.isEmpty){
                                await _controller.deleteAt(index);
                              }else{
                                await _controller.updateAt(index, message);
                              }
                              Get.back();
                            },
                          )
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.bottomSheet(
            MyChecklistBottomSheet(
              onSave: (message) async {
                await _controller.addTodo(message);
                Get.back();
              },
            )
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
