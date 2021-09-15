import 'package:flutter/material.dart';

import 'constants.dart';

final _base = ThemeData.light();

final appTheme = _base.copyWith(
  primaryColor: primaryColor,
  primaryColorLight: primaryColorLight,
  primaryColorDark: primaryColorDark,
  colorScheme: _base.colorScheme.copyWith(
    primary: primaryColor, // affect Appbar
    primaryVariant: primaryColorLight,
    onPrimary: Colors.white,
    secondary: secondaryColorLight, // affect FloatingActionButton
    secondaryVariant: secondaryColor,
    onSecondary: Colors.black,
  ),
  textTheme: _textTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: pillShape,
      padding: const EdgeInsets.all(defaultPadding),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
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
    fontSize: 30.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  headline5: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  ),
  headline6: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  ),
  subtitle1: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  ),
  subtitle2: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  ),
  bodyText1: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  bodyText2: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  button: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
    color: primaryColor,
  ),
  caption: TextStyle(
    fontFamily: 'Rubik',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
);