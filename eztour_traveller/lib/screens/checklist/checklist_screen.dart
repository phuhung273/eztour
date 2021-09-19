
import 'dart:ui';

import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/screens/checklist/checklist_controller.dart';
import 'package:eztour_traveller/screens/main/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

final colorList = [
  HexColor('#34495e'),
  HexColor('#3780d8'),
  thirdColorDark,
  fourthColorDark,
  primaryColorDark,
  secondaryColorDark,
];

class ChecklistScreen extends StatelessWidget {

  final ChecklistScreenController _controller = Get.put(ChecklistScreenController());
  final MainScreenController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: (){},
        ),
        // title: Text(_controller.greeting.value),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _mainController.logOut,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: defaultSpacing),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.add, color: theme.colorScheme.onSurface),
                      label: Text(
                        'Add checklist',
                        style: theme.textTheme.button!.copyWith(
                          color: theme.colorScheme.onSurface
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    itemCount: _controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = _controller.categories.keys.elementAt(index);

                      return InkWell(
                        onTap: () => Get.toNamed(ROUTE_CHECKLIST_DETAIL, arguments: category),
                        child: ChecklistCard(
                          key: UniqueKey(),
                          title: category,
                          todos: _controller.categories[category]!,
                          color: colorList[index],
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}

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
      children: [
        Padding(
          padding: const EdgeInsets.only(right: defaultPadding),
          child: _buildCheckIcon(todo.isDone(), theme.textTheme.bodyText1!.fontSize!),
        ),
        Text(
          todo.message,
          style: theme.textTheme.bodyText2!.copyWith(
            color: Colors.white,
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
