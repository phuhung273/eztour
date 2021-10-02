
import 'dart:ui';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/enum.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/screens/checklist/checklist_controller.dart';
import 'package:eztour_traveller/screens/main/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'checklist_card.dart';

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
                      onPressed: () => Get.toNamed(
                        ROUTE_MY_CHECKLIST,
                        parameters: {
                          modeParams: EnumToString.convertToString(Mode.Add),
                        }
                      ),
                      icon: Icon(Icons.add, color: theme.colorScheme.onSurface),
                      label: Text(
                        'Add checklist',
                        style: theme.textTheme.button!.copyWith(
                          color: theme.colorScheme.onSurface
                        ),
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
                    itemCount: _controller.categories.length + _controller.myCategories.length,
                    itemBuilder: (context, index) {
                      // Admin checklist
                      if(index < _controller.categories.length){
                        final category = _controller.categories.keys.elementAt(index);

                        return InkWell(
                          onTap: () => Get.toNamed(ROUTE_CHECKLIST_DETAIL, arguments: category),
                          child: ChecklistCard(
                            title: category,
                            todos: _controller.categories[category]!,
                            color: _getCardColor(index),
                          ),
                        );
                      }

                      // My checklist
                      final myIndex = index - _controller.categories.length;
                      final category = _controller.myCategories.keys.elementAt(myIndex);

                      return InkWell(
                        onTap: () => Get.toNamed(
                          ROUTE_MY_CHECKLIST,
                          parameters: {
                            categoryParams: category,
                            modeParams: EnumToString.convertToString(Mode.Edit),
                          }
                        ),
                        child: ChecklistCard(
                          title: category,
                          todos: _controller.myCategories[category]!,
                          color: _getCardColor(index),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                )
              ),
              const Divider(height: defaultSpacing)
            ],
          ),
        )
      ),
    );
  }

  Color _getCardColor(int index){
    return colorList[index % colorList.length];
  }
}
