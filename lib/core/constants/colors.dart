import 'package:flutter/material.dart';

class KColors {
  static const grey = Color(0xffb4c9de);
  static const greyLight = Color(0xfff8f8fa);
  static const green = Color(0xff02A499);
  static const blue = Color(0xff1BB1E7);

  static const success = Color(0xff02a499);
  static const danger = Color(0xffec4561);
  static const warning = Color(0xfff8b425);
  static const info = Color(0xff38a4f8);

  static const secondaryLight = Color(0xffffb944);
  static const secondary = Color(0xffFFA715);
  static const secondaryDark = Color(0xffcc8611);

  static final background = primary.shade900;
  static final primaryLight = primary.shade200;

  static const int _primaryValue = 0xff21293b;
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xffe9eaec), //10%
      100: Color(0xffbec0c6), //20%
      200: Color(0xff9297a0), //30%
      300: Color(0xff3b4354), //40%
      400: Color(0xff252e41), //50%
      500: Color(_primaryValue), //60%
      600: Color(0xff1e2534), //70%
      700: Color(0xff1a202e), //80%
      800: Color(0xff1b2230), //90%
      900: Color(0xff131822),
    },
  );
}
