import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/screens/checklist/checklist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChecklistDetailScreen extends GetView<ChecklistScreenController> {

  final _categoryName = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Obx(
          (){
            final category = controller.categories[_categoryName]!;
            return ListView.separated(
              itemCount: category.length,
              itemBuilder: (context, index){
                final todo = category[index];

                return ListTile(
                  leading: _buildCheckIcon(todo.isDone()),
                  minLeadingWidth: 0,
                  title: Text(
                    todo.message,
                    style: theme.textTheme.bodyText1,
                  ),
                  onTap: () => controller.toggle(todo),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCheckIcon(bool done){
    return done ? const Icon(Icons.check_circle, color: Colors.green)
        : const Icon(Icons.radio_button_unchecked, color: Colors.black);
  }
}
