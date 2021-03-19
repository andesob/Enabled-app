import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier{
  final lightTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  );

  final darkTheme = ThemeData(
  backgroundColor: Color(StaticColors.lightPeach),
  brightness: Brightness.dark,
  );

  static bool _isDark = false;

  ThemeData getTheme(){
    print("new theme set");
    return _isDark ? darkTheme : lightTheme;
  }

  void switchTheme(){
    print("theme switched");
    _isDark = !_isDark;
    print(_isDark);
    notifyListeners();
  }
}

