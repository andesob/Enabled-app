import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
  );
  ThemeNotifier();

  getTheme() => _themeData;

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
  );

  final darkTheme = ThemeData(
    backgroundColor: Color(StaticColors.lightPeach),
    brightness: Brightness.dark,
  );

  static bool _isDark = false;

  void switchTheme() {
    print("theme switched");
    _isDark = !_isDark;
    print(_isDark);
    _themeData = _isDark ? darkTheme : lightTheme;
    notifyListeners();
  }
}
