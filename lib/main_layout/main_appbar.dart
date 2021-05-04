import 'package:enabled_app/desktop_connection/ip_popup.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:enabled_app/main_layout/themes.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hasDropDown;

  const MyAppBar({
    Key key,
    this.title,
    this.hasDropDown = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class MyAppBarState extends State<MyAppBar> {
  ThemeNotifier themeNotifier;
  bool isDark;
  bool isNorwegian = TTSController().getCurrentLanguage() == "US";

  createDropDown() {
    return <Widget>[
      Material(
        type: MaterialType.transparency,
        child: PopupMenuButton(
          icon: Icon(
            Icons.list,
          ),
          itemBuilder: (BuildContext bc) => [
            PopupMenuItem(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Row(
                  children: [
                    Text("Dark Mode"),
                    Spacer(),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        setState(() {
                          themeNotifier.switchTheme();
                          isDark = value;
                        });
                      },
                    ),
                  ],
                );
              }),
              value: 0,
            ),
            PopupMenuItem(
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Row(
                  children: [
                    Text("TTS Language"),
                    Spacer(),
                    Flag(
                      'NO',
                      width: 15,
                      height: 15,
                    ),
                    Switch(
                      value: isNorwegian,
                      onChanged: (value) {
                        setState(() {
                          TTSController().changeLanguage();
                          isNorwegian = !isNorwegian;
                        });
                      },
                    ),
                    Flag(
                      'GB',
                      height: 15,
                      width: 20,
                    )
                  ],
                );
              }),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Change Emergency Contact"),
              value: 2,
            ),
            PopupMenuItem(
              child: Text("Show Mobile IP address"),
              value: 3,
            ),
          ],
          onSelected: (selected) {
            if (selected == 0) {
              setState(() {
                //themeNotifier.switchTheme();
              });
            }
            if (selected == 1) {
              //TTSController().changeLanguage();
            }
            if (selected == 2) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EmergencyPopup();
                  });
            }
            if (selected == 3) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return IpPopup();
                  });
            }
          },
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    themeNotifier = Provider.of<ThemeNotifier>(context);
    isDark = themeNotifier.isDark;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return PreferredSize(
      preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
      child: GradientAppBar(
        title: Text(
          widget.title,
        ),
        gradient: LinearGradient(
            colors: isDark
                ? [Colors.transparent, Colors.transparent]
                : [
                    Color(StaticColors.lightPeach),
                    Color(StaticColors.darkPeach)
                  ]),
        actions: widget.hasDropDown ? createDropDown() : null,
      ),
    );
  }
}
