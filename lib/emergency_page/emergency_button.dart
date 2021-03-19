import 'dart:ui';

import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/emergency_page/emergency_alert.dart';

import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gradient_text/gradient_text.dart';

class EmergencyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
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
