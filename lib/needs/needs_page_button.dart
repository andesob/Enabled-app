import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  FlutterTts flutterTts = TTSController().flutterTts;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    bool isMobile = shortestSide < 600;
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
        textColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                GradientText(
                  widget.text,
                  style: TextStyle(fontSize: isMobile ? 10 : 20),
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
        onPressed: () {
          flutterTts.speak(widget.text);
        },
      ),
    );
  }
}
