import 'dart:ui';

import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:enabled_app/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class MainPageButton extends StatefulWidget {
  String text;
  bool darkmode = false;
  bool focused = false;
  MainPageButtonState state;

  MainPageButton({Key key, this.text}) : super(key: key);

  @override
  MainPageButtonState createState() {
    state = MainPageButtonState();
    return state;
  }
}

class MainPageButtonState extends State<MainPageButton> {
  goToPage(context) {
    Navigator.pushNamed(context, widget.text);
  }

  setFocus() {
    setState(() {
      widget.focused = true;
    });
  }

  removeFocus(){
    setState(() {
      widget.focused = false;
    });
  }

  void initState() {
    super.initState();
    if (widget.text == Strings.needs) {
      setFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      margin: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(widget.focused
            ? StaticColors.deepSpaceSparkle
            : StaticColors.lighterSlateGray),
        /*gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),*/
      ),
      child: FlatButton(
        child: new GradientText(
          widget.text,
          style: TextStyle(
              color: Color(
                  widget.darkmode ? StaticColors.black : StaticColors.white)),
          gradient: new LinearGradient(
            colors: [lightPeach, darkPeach],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        onPressed: () {
          goToPage(context);
        },
      ),
    );
  }
}
