import 'package:enabled_app/contacts_page//contacts.dart';
import 'package:enabled_app/home_page/home_page.dart';
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
    //final themeState = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: Strings.enabled,
      initialRoute: Strings.home,
      //theme: themeState.getTheme(),
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      routes: {
        Strings.home: (context) => MainPage(
            pageContent: MyHomePage(
                key: PageGlobalKeys.homePageKey, title: Strings.home),
            title: Strings.home,
            hasDropDown: true,
            pageKey: PageGlobalKeys.homePageKey),
        Strings.needs: (context) => MainPage(
            pageContent: NeedsPage(key: PageGlobalKeys.needsPageKey),
            title: Strings.needs,
            hasDropDown: false,
            pageKey: PageGlobalKeys.needsPageKey),
        Strings.contacts: (context) => MainPage(
              pageContent: contacts(
                key: PageGlobalKeys.contactsPageKey,
              ),
              title: Strings.contacts,
              hasDropDown: false,
              pageKey: PageGlobalKeys.contactsPageKey,
            ),
        Strings.custom: (context) => MainPage(
              pageContent: CustomPageHome(
                key: PageGlobalKeys.customPageKey,
              ),
              title: Strings.custom,
              hasDropDown: false,
              pageKey: PageGlobalKeys.customPageKey,
            ),
        Strings.keyboard: (context) => MainPage(
              pageContent: KeyboardPage(
                key: PageGlobalKeys.keyboardPageKey,
              ),
              title: Strings.keyboard,
              hasDropDown: false,
              pageKey: PageGlobalKeys.keyboardPageKey,
            ),
        Strings.smart: (context) => MainPage(
              pageContent: SmartMainPage(
                key: PageGlobalKeys.smartPageKey,
              ),
              title: Strings.smart,
              hasDropDown: false,
              pageKey: PageGlobalKeys.smartPageKey,
            ),
        Strings.hue: (context) => MainPage(
              pageContent: HuePage(key: PageGlobalKeys.huePageKey),
              title: Strings.hue,
              hasDropDown: false,
              pageKey: PageGlobalKeys.huePageKey,
            ),
      },
    );
  }
}
