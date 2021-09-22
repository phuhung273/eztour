
import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';

mixin Swipeable {

  Widget buildIconButton(Color color, IconData icon) {
    return Container(
      width: 60.0,
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: thinRoundedRectangleBorderRadius,
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20.0,
      ),
    );
  }
}