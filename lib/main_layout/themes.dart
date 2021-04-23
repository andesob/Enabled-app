import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          color: Color(StaticColors.lighterSlateGray),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
  ThemeNotifier();

  getTheme() => _themeData;

  ThemeData lightTheme;

  ThemeData darkTheme;

  bool isDark = false;

  void switchTheme() {
    isDark = !isDark;
    _themeData = isDark ? darkTheme : lightTheme;
    notifyListeners();
  }
}
