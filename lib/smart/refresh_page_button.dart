import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class RefreshPageButton extends StatefulWidget {
  final String text;
  final bool focused;
  final bool enabled;
  final VoidCallback refresh;

  RefreshPageButton({
    Key key,
    this.text,
    this.focused = false,
    this.enabled = true,
    this.refresh,
  }) : super(key: key);

  @override
  RefreshPageButtonState createState() => RefreshPageButtonState();
}

class RefreshPageButtonState extends State<RefreshPageButton> {
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
            : StaticColors.onyx),
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
          widget.refresh?.call();
        },
      ),
    );
  }
}
