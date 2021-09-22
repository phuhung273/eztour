import 'package:flutter/material.dart';

class KeyboardFriendlyBody extends StatelessWidget {
  final Widget child;
  const KeyboardFriendlyBody({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: child,
      ),
    );
  }
}
