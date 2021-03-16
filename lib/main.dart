import 'package:enabled_app/Contacts/contacts.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:enabled_app/libraries/hue/main/bridge_api.dart';
import 'package:enabled_app/main_page.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:enabled_app/philips_hue/hue_page.dart';
import 'package:enabled_app/smart/smart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'libraries/hue/lights/light.dart';
import 'main_page/home_page.dart';
import 'colors/colors.dart';
import 'strings/strings.dart';
import 'package:enabled_app/custom_page/custom_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.enabled,
      initialRoute: Strings.home,
      routes: {
        Strings.home: (context) => MainPage(
              pageContent: MyHomePage(
                title: Strings.home,
              ),
            ),
        Strings.needs: (context) => MainPage(pageContent: NeedsPage(title: Strings.needs)),
        Strings.contacts: (context) => MainPage(pageContent: contacts(title: Strings.contacts)),
        Strings.custom: (context) => MainPage(pageContent: CustomPageHome(title: Strings.custom)),
        Strings.keyboard: (context) => MainPage(pageContent: KeyboardPage(title: Strings.keyboard)),
        Strings.smart: (context) => MainPage(pageContent: SmartMainPage(title: Strings.smart)),
        Strings.hue: (context) => MainPage(pageContent: HuePage()),
      }, //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
