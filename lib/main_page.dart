import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/main_layout/input_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global_data/strings.dart';

/// Widget representing the Main page
class MainPage extends StatefulWidget {
  MainPage({
    Key key,
    this.pageContent,
    this.title,
    this.pageKey,
    this.hasDropDown,
    this.darkmode,
  }) : super(key: key);
  /// The widget currently shown in the body
  final StatefulWidget pageContent;

  /// Variable that sets the title shown in the top appbar
  final String title;

  /// The global key belonging to the widget in the body
  final GlobalKey<PageState> pageKey;

  /// Variable that tells if the page should have a dropdown menu
  final bool hasDropDown;

  /// Variable that tells if the theme is set to dark mode
  final bool darkmode;

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color backgroundColor = Color(StaticColors.onyx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () async {
          if (widget.title == Strings.HOME) {
            return false;
          } else if (widget.title == Strings.HUE) {
            Navigator.pushReplacementNamed(context, Strings.SMART);
          } else {
            Navigator.pushReplacementNamed(context, Strings.HOME);
          }
          return false;
        },
        child: Scaffold(
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
