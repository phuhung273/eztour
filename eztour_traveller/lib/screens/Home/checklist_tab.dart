
import 'dart:math';

import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/checklist/todo_category.dart';
import 'package:flutter/material.dart';

const TODO_LIMIT = 3;

final colorMap = [
  fourthColor,
  secondaryColor,
  primaryColor,
];

final iconMap = [
  Icons.menu_book,
  Icons.accessibility,
  Icons.wash,
];

const RIBBON_WIDTH = 60.0;
const RIBBON_HEIGHT = 100.0;

class ChecklistTab extends StatelessWidget {
  final List<TodoCategory> todoCategories;

  const ChecklistTab({
    Key? key,
    required this.todoCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(TODO_LIMIT, todoCategories.length),
      itemBuilder: (BuildContext context, int index)
        => TodoCategoryCard(
          category: todoCategories[index],
          color: colorMap[index],
          icon: iconMap[index],
        ),
      separatorBuilder: (BuildContext context, int index)
        => const SizedBox(height: defaultPadding),
    );
  }
}

class TodoCategoryCard extends StatelessWidget {
  final TodoCategory category;
  final Color color;
  final IconData icon;

  const TodoCategoryCard({
    Key? key,
    required this.category,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: defaultSpacing),
      child: Stack(
        clipBehavior: Clip.none,
        children:[
          Card(
            margin: EdgeInsets.zero,
            elevation: 2.0,
            child: Container(
              height: 120.0,
              margin: const EdgeInsets.only(left: RIBBON_WIDTH + defaultPadding),
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.name,
                          style: theme.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const Icon(Icons.more_horiz),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: min(TODO_LIMIT, category.todos.length),
                    itemBuilder: (context, index){
                      final todo = category.todos[index];

                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: defaultPadding),
                            child: _buildCheckIcon(todo.isDone(), theme.textTheme.bodyText2!.fontSize!),
                          ),
                          Text(todo.message, style: theme.textTheme.bodyText2),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index)
                      => const SizedBox(height: defaultPadding),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -defaultPadding,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: ClipPath(
                clipper: RibbonClipper(),
                child: Container(
                  height: RIBBON_HEIGHT,
                  width: RIBBON_WIDTH,
                  decoration: BoxDecoration(
                      color: color
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: theme.textTheme.headline4!.fontSize,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -defaultPadding,
            left: RIBBON_WIDTH + defaultPadding, // ribbon has left padding
            child: ClipPath(
              clipper: RibbonShadowClipper(),
              child: Container(
                height: defaultPadding,
                width: defaultPadding,
                decoration: BoxDecoration(
                    color: color.darken(0.35),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCheckIcon(bool done, double size){
    return done ? Icon(Icons.check_circle, color: Colors.green, size: size)
        : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: size);
  }
}

class RibbonShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.quadraticBezierTo(size.width, 0, size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.5, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}