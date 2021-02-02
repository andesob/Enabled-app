import 'dart:ui';

import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:flutter/material.dart';

class MainPageButton extends StatelessWidget {
  String text;
  bool darkmode;

  MainPageButton(String text, bool darkmode) {
    this.text = text;
    this.darkmode = darkmode;
  }

  goToPage(context) {
    Navigator.pushNamed(context, text);
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);
    Color buttonColor = Color(StaticColors.greenSheen);

    return Container(
      margin: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: buttonColor,
        /*gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),*/
      ),
      child: FlatButton(
        child: new Text(
          text,
          style: TextStyle(color: Color(darkmode ? StaticColors.black : StaticColors.white)),
        ),
        onPressed: () {
          goToPage(context);
        },
      ),
    );
  }
}
