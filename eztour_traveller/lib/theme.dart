import 'package:flutter/material.dart';

import 'constants.dart';

final _base = ThemeData.light();

final appTheme = _base.copyWith(
  primaryColor: primaryColor,
  primaryColorLight: primaryColorLight,
  primaryColorDark: primaryColorDark,
  indicatorColor: primaryColor,
  colorScheme: _base.colorScheme.copyWith(
    primary: primaryColor, // affect Appbar
    primaryVariant: primaryColorLight,
    onPrimary: Colors.white,
    secondary: secondaryColor, // affect FloatingActionButton
    secondaryVariant: secondaryColorLight,
    onSecondary: Colors.white,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    onBackground: onSurfaceColor,
  ),
  textTheme: _textTheme,
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     shape: pillShape,
  //     padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding * 2),
  //   ),
  // ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.white,
    space: defaultPadding,
  )
);

final _textTheme = _base.textTheme.copyWith(
  headline1: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 96.0,
    fontWeight: FontWeight.w300,
    color: primaryColor,
  ),
  headline2: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 60.0,
    fontWeight: FontWeight.w300,
    color: primaryColor,
  ),
  headline3: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 48.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  // Only use below headline4
  headline4: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 34.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  headline5: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  ),
  headline6: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  ),
  subtitle1: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: onSurfaceColor,
  ),
  subtitle2: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: onSurfaceColor,
  ),
  bodyText1: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  ),
  bodyText2: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  ),
  button: const TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    // letterSpacing: 1.1,
  ),
  caption: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  ),
);