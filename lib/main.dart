import 'package:enabled_app/contacts_page//contacts.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:enabled_app/libraries/hue/main/bridge_api.dart';
import 'package:enabled_app/main_page.dart';
import 'package:enabled_app/main_layout/themes.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:enabled_app/page_global_keys.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/philips_hue/hue_page.dart';
import 'package:enabled_app/smart/smart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'libraries/hue/lights/light.dart';
import 'main_page/home_page.dart';
import 'package:provider/provider.dart';
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
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        backgroundColor: Color(StaticColors.lightPeach),
        brightness: Brightness.dark,
      ),
      routes: {
        Strings.home: (context) => MainPage(
            pageContent: MyHomePage(
                key: PageGlobalKeys.homePageKey, title: Strings.home),
            title: Strings.home,
            pageKey: PageGlobalKeys.homePageKey),
        Strings.needs: (context) => MainPage(
            pageContent: NeedsPage(key: PageGlobalKeys.needsPageKey),
            title: Strings.needs,
            pageKey: PageGlobalKeys.needsPageKey),
        Strings.contacts: (context) => MainPage(
              pageContent: contacts(
                key: PageGlobalKeys.contactsPageKey,
              ),
              title: Strings.contacts,
              pageKey: PageGlobalKeys.contactsPageKey,
            ),
        Strings.custom: (context) => MainPage(
              pageContent: CustomPageHome(
                key: PageGlobalKeys.customPageKey,
              ),
              title: Strings.custom,
              pageKey: PageGlobalKeys.customPageKey,
            ),
        Strings.keyboard: (context) => MainPage(
              pageContent: KeyboardPage(
                key: PageGlobalKeys.keyboardPageKey,
              ),
              title: Strings.keyboard,
              pageKey: PageGlobalKeys.keyboardPageKey,
            ),
        Strings.smart: (context) => MainPage(
              pageContent: SmartMainPage(
                key: PageGlobalKeys.smartPageKey,
              ),
              title: Strings.smart,
              pageKey: PageGlobalKeys.smartPageKey,
            ),
        Strings.hue: (context) => MainPage(
              pageContent: HuePage(key: PageGlobalKeys.huePageKey),
              title: Strings.hue,
              pageKey: PageGlobalKeys.huePageKey,
            ),
      }, //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
