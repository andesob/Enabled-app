import 'dart:ui';

import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class NeedsPageButton extends StatefulWidget {
  NeedsPageButton({Key key, this.text, this.icon}) : super(key: key);
  final String text;
  final Icon icon;
  bool isFocused = false;
  _NeedsPageButton state;

  @override
  _NeedsPageButton createState() {
    state = _NeedsPageButton();
    return state;
  }

//TODO
//var picture;
}

class _NeedsPageButton extends State<NeedsPageButton> {
  String text;

  @override
  void initState() {
    super.initState();
    text = widget.text;
  }

  /// Sets the focus the button to true
  void setFocus() {
    if (this.mounted) {
      setState(() {
        widget.isFocused = true;
      });
    } else {
      print("not mounted");
    }
  }

  /// Removes the focus of the button.
  void removeFocus() {
    setState(() {
      widget.isFocused = false;
    });
  }

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
            color: widget.isFocused ? Colors.black : Colors.black12,
          ),
        ),
        textColor: Colors.white,
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
