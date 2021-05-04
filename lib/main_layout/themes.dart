import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  SharedPreferences prefs;

  ThemeData lightTheme = ThemeData(
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

  ThemeData darkTheme = ThemeData(
    primaryColor: Color(StaticColors.lightGray),
    backgroundColor: Color(StaticColors.lightPeach),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      textTheme: ThemeData.dark().textTheme.copyWith(
        headline6: TextStyle(
          color: Color(StaticColors.lightPeach),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  ThemeData _themeData;
  bool isDark = false;

  ThemeNotifier() {
    _themeData = lightTheme;
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    bool prefDarkmode = prefs.getBool("darkmode");
    if (prefDarkmode == true) {
      switchTheme();
    }
  }

  getTheme() => _themeData;

  void switchTheme() {
    isDark = !isDark;
    _themeData = isDark ? darkTheme : lightTheme;
    notifyListeners();
    prefs.setBool("darkmode", isDark);
  }
}
