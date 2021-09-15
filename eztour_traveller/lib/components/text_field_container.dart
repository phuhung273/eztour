import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultSpacing),
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: theme.primaryColor),
        borderRadius: pillBorderRadius,
      ),
      child: child,
    );
  }
}
