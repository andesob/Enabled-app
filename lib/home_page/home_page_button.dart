import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class HomePageButton extends StatefulWidget {
  final String text;
  final bool focused;

  HomePageButton({
    Key key,
    this.text,
    this.focused = false,
  }) : super(key: key);

  @override
  HomePageButtonState createState() => HomePageButtonState();
}

class HomePageButtonState extends State<HomePageButton> {
  void pushPressed(){
    Navigator.pushNamed(context, widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(widget.focused
            ? StaticColors.deepSpaceSparkle
            : StaticColors.lighterSlateGray),
      ),
      child: FlatButton(
        child: new GradientText(
          widget.text,
          gradient: new LinearGradient(
            colors: [
              Color(StaticColors.lightPeach),
              Color(StaticColors.darkPeach)
            ],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        onPressed: () {
          pushPressed();
        },
      ),
    );
  }
}
