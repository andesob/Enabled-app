import 'dart:async';

import 'package:enabled_app/contacts_page/contact_page.dart';
import 'package:enabled_app/desktop_connection/server_socket.dart';
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
import 'global_data/colors.dart';
import 'global_data/strings.dart';
import 'package:enabled_app/custom_page/custom_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(),
        child: MyApp(),
      ),
    );
  });
  SocketSingleton socket = SocketSingleton();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.ENABLED,
      initialRoute: Strings.HOME,
      theme: themeNotifier.getTheme(),
      routes: {
        Strings.HOME: (context) => MainPage(
            pageContent: MyHomePage(key: PageGlobalKeys.homePageKey),
            title: Strings.HOME,
            hasDropDown: true,
            pageKey: PageGlobalKeys.homePageKey),
        Strings.NEEDS: (context) => MainPage(
            pageContent: NeedsPage(key: PageGlobalKeys.needsPageKey),
            title: Strings.NEEDS,
            hasDropDown: false,
            pageKey: PageGlobalKeys.needsPageKey),
        Strings.CONTACTS: (context) => MainPage(
              pageContent: ContactPage(
                key: PageGlobalKeys.contactsPageKey,
              ),
              title: Strings.CONTACTS,
              hasDropDown: false,
              pageKey: PageGlobalKeys.contactsPageKey,
            ),
        Strings.CUSTOM: (context) => MainPage(
              pageContent: CustomPageHome(
                key: PageGlobalKeys.customPageKey,
              ),
              title: Strings.CUSTOM,
              hasDropDown: false,
              pageKey: PageGlobalKeys.customPageKey,
            ),
        Strings.KEYBOARD: (context) => MainPage(
              pageContent: KeyboardPage(
                key: PageGlobalKeys.keyboardPageKey,
              ),
              title: Strings.KEYBOARD,
              hasDropDown: false,
              pageKey: PageGlobalKeys.keyboardPageKey,
            ),
        Strings.SMART: (context) => MainPage(
              pageContent: SmartMainPage(
                key: PageGlobalKeys.smartPageKey,
              ),
              title: Strings.SMART,
              hasDropDown: false,
              pageKey: PageGlobalKeys.smartPageKey,
            ),
        Strings.HUE: (context) => MainPage(
              pageContent: HuePage(key: PageGlobalKeys.huePageKey),
              title: Strings.HUE,
              hasDropDown: false,
              pageKey: PageGlobalKeys.huePageKey,
            ),
      },
    );
  }
}
