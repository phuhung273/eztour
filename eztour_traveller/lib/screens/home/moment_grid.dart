
import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SharingGrid extends StatelessWidget {
  final String title;
  final List<String> imagePathList;
  final double borderRadius;

  const SharingGrid({
    Key? key,
    required this.title,
    required this.imagePathList,
    this.borderRadius = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(title, style: theme.textTheme.headline4)
        ),
        StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          itemCount: imagePathList.length,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Image.network(imagePathList[index]),
            );
          },
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        ),
      ],
    );
  }
}
