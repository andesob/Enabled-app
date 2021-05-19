import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

/// Widget representing a button on the [MyHomePage]
class HomePageButton extends StatefulWidget {
  /// Text displayed on the button
  final String text;

  /// True if button is focused
  final bool focused;

  /// [bool] to disable the button
  final bool enabled;

  HomePageButton({
    Key key,
    this.text,
    this.focused = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  HomePageButtonState createState() => HomePageButtonState();
}

class HomePageButtonState extends State<HomePageButton> {
  /// Navigate to page when button is pressed
  void pushPressed() {
    if (widget.enabled) Navigator.pushReplacementNamed(context, widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(widget.enabled
            ? (widget.focused
                ? StaticColors.deepSpaceSparkle
                : StaticColors.lighterSlateGray)
            : StaticColors.lighterNightRider),
      ),
      child: FlatButton(
        child: new GradientText(
          widget.text,
          style: TextStyle(fontSize: 20),
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
