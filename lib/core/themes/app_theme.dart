import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    primarySwatch: KColors.primary,
    canvasColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.brown.shade50,
    ),
    // appBarTheme: AppBarTheme(titleTextStyle: TextStyle()),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // static final darkTheme = ThemeData(
  //   primarySwatch: darkSwatch,
  //   backgroundColor: darkSwatch,
  //   canvasColor: darkSwatch.shade900,
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: Colors.deepOrange.shade50,
  //   ),
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  // );
}
