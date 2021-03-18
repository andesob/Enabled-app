import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/main_layout/button_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/main_page/home_page.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
    this.pageContent,
    this.title,
    this.pageKey,
  }) : super(key: key);
  final StatefulWidget pageContent;
  final String title;
  final GlobalKey<PageState> pageKey;

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color backgroundColor = Color(StaticColors.onyx);
  bool darkmode = false;

  @override
  void initState() {
    super.initState();
  }

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
      child: Scaffold(
        backgroundColor: darkmode ? backgroundColor : Colors.white,
        appBar: MyAppBar(
          title: widget.title,
          hasDropDown: true,
        ),
        body: widget.pageContent,
        bottomNavigationBar: ButtonController(
          pageKey: widget.pageKey,
        ),
      ),
    );
  }
}
