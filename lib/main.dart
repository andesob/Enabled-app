import 'package:enabled_app/needs/needs.dart';
import 'package:flutter/material.dart';
import 'main_page/main_page.dart';
import 'colors/colors.dart';
import 'strings/strings.dart';
import 'package:enabled_app/custom_page/CustomPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.enabled,
      initialRoute: Strings.home,
      routes: {
        Strings.home: (context) => MyHomePage(),
        Strings.needs: (context) => NeedsPage(),
        Strings.custom: (context) => CustomPageHome(),
      }, //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
