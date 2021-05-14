import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

/// Widget representing the emergency button on [MyHomePage]
class EmergencyButton extends StatefulWidget {
  /// Text displayed on the button
  final String text;

  /// The Callback called when button is pressed
  final VoidCallback onPressed;

  /// True if button currently focused
  final bool focused;

  EmergencyButton({
    Key key,
    this.text,
    this.focused = false,
    this.onPressed,
  }) : super(key: key);

  @override
  EmergencyButtonState createState() => EmergencyButtonState();
}

class EmergencyButtonState extends State<EmergencyButton> {
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
          widget.onPressed?.call();
        },
      ),
    );
  }
}
