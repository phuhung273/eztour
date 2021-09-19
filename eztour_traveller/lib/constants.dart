import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final primaryColor = HexColor('#5abaae');
final primaryColorLight = HexColor('#8dede0');
final primaryColorDark = HexColor('#218a7f');
final secondaryColor = HexColor('#ff868f');
final secondaryColorLight = HexColor('#ffb8bf');
final secondaryColorDark = HexColor('#c85662');
final surfaceColor = HexColor('#ededed');
final onSurfaceColor = HexColor('#232323');
final thirdColor = HexColor('#f6bd60');
final thirdColorDark = HexColor('#c08d31');
final fourthColor = HexColor('#565656');
final fourthColorDark = HexColor('#565656');

const defaultSpacing = 16.0;

const defaultPadding = 8.0;

final pillBorderRadius = BorderRadius.circular(999);
final roundedRectangleBorderRadius = BorderRadius.circular(16.0);

final pillShape = RoundedRectangleBorder(
  borderRadius: pillBorderRadius,
);

final roundedRectangleShape = RoundedRectangleBorder(
  borderRadius: roundedRectangleBorderRadius,
);

const HOST_URL = 'http://157.245.60.30';
const CHAT_HOST_URL = 'http://157.245.60.30';

// const HOST_URL = 'http://10.0.2.2:8000';
// const CHAT_HOST_URL = 'http://10.0.2.2:3000';
