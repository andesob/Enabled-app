import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/main_layout/input_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global_data/strings.dart';

class MainPage extends StatefulWidget {
  MainPage(
      {Key key, this.pageContent, this.title, this.pageKey, this.hasDropDown})
      : super(key: key);
  final StatefulWidget pageContent;
  final String title;
  final GlobalKey<PageState> pageKey;
  final bool hasDropDown;

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color backgroundColor = Color(StaticColors.onyx);
  bool darkmode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (widget.title != Strings.HOME) {
            Navigator.pushReplacementNamed(context, Strings.HOME);
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: darkmode ? backgroundColor : Colors.white,
          appBar: MyAppBar(
            title: widget.title,
            hasDropDown: widget.hasDropDown,
          ),
          body: widget.pageContent,
          bottomNavigationBar: ButtonController(
            pageKey: widget.pageKey,
          ),
        ),
      ),
    );
  }
}
