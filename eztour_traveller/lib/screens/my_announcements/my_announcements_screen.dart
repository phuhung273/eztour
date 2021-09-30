import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/mixins/dialog.dart';
import 'package:eztour_traveller/screens/my_checklist/my_checklist_bottomsheet.dart';
import 'package:eztour_traveller/widgets/keyboard_friendly_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'annoucement_tile.dart';
import 'my_announcements_controller.dart';

class MyAnnouncementScreen extends StatelessWidget with Dialogable{

  final MyAnnouncementScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleHinText = _controller.category.isEmpty ? 'Title' : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your notes'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.deleteCategory();
              Get.back();
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              final result = _controller.submit();
              result.then((value){
                if(value){
                  Get.back();
                } else {
                  _showInvalidTitle(context);
                }
              });
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
                  itemCount: _controller.items.length,
                  itemBuilder: (context, index){
                    final item = _controller.items[index];

                    return AnnouncementTile(
                      item: item,
                      onDelete: () => _controller.deleteAt(index),
                      onUpdate: () => Get.bottomSheet(
                          MyChecklistBottomSheet(
                            initialMessage: item.message,
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
                await _controller.add(message);
                Get.back();
              },
            )
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showInvalidTitle(BuildContext context){
    showErrorDialog(context, 'Invalid Title');
  }
}