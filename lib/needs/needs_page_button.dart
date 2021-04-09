import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class NeedsPageButton extends StatefulWidget {
  NeedsPageButton({
    Key key,
    this.text,
    this.icon,
    this.isFocused = false,
  }) : super(key: key);
  final String text;
  final Icon icon;
  final bool isFocused;

  @override
  _NeedsPageButton createState() => _NeedsPageButton();
}

class _NeedsPageButton extends State<NeedsPageButton> {
  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);

    return Container(
      margin: EdgeInsets.all(5),
      child: new RaisedButton(
        highlightColor: Color(StaticColors.deepSpaceSparkle),
        color: widget.isFocused
            ? Color(StaticColors.deepSpaceSparkle)
            : Color(StaticColors.lighterSlateGray),
        elevation: widget.isFocused ? 10 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                GradientText(
                  widget.text,
                  style: TextStyle(fontSize: 12),
                  gradient: new LinearGradient(
                    colors: [lightPeach, darkPeach],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                ),
              ],
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}