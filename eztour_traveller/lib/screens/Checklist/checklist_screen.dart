
import 'dart:ui';

import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/screens/Checklist/checklist_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

const imageMap = {
  'Travel Documents': 'travel_documents.jpg',
  'Clothing Essentials': 'clothes.png'
};

class ChecklistScreen extends StatelessWidget {

  final ChecklistScreenController _controller = Get.put(ChecklistScreenController());

  Widget _buildCheckIcon(bool done){
    return done ? const Icon(Icons.check_circle, color: Colors.green, size: 20.0)
        : const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Checklist",
              style: TextStyle(fontSize: 25.0),
            ),
            GetBuilder<ChecklistScreenController>(
              builder: (_) => GroupedListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                elements: _controller.todos,
                groupBy: (Todo item) => item.category,
                groupSeparatorBuilder: (String category) => _buildCategoryHeader(category),
                itemBuilder: (context, Todo item){
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child:  ListTile(
                      title: Text(item.message, style: const TextStyle(fontSize: 16)),
                      trailing: IconButton(
                        icon: _buildCheckIcon(item.isDone()),
                        onPressed: () => _controller.toggleTodo(item.id),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String category){
    final imagePath = imageMap[category];

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 2.0,
      margin: const EdgeInsets.only(top: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100.0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/$imagePath"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Center(
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ]
      ),
    );
  }
}
