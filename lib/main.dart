import 'package:enabled_app/Contacts/contacts.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:enabled_app/smart/smart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_page/main_page.dart';
import 'colors/colors.dart';
import 'strings/strings.dart';
import 'package:enabled_app/custom_page/custom_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.enabled,
      initialRoute: Strings.hue,
      routes: {
        Strings.home: (context) => MyHomePage(title: Strings.home),
        Strings.needs: (context) => NeedsPage(title: Strings.needs),
        Strings.contacts: (context) => contacts(title: Strings.contacts),
        Strings.custom: (context) => CustomPageHome(title: Strings.custom),
        Strings.keyboard: (context) => KeyboardPage(title: Strings.keyboard),
        Strings.smart: (context) => SmartMainPage(title: Strings.smart),
      }, //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
