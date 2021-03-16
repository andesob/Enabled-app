import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifyer extends ChangeNotifier{
  static bool _isDark = false;

  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(){
    _isDark = !_isDark;
    notifyListeners();
  }
}