import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

// TODO Change the flatButton to raisedButton??
class CustomPageButton extends StatefulWidget {
  CustomPageButton({
    Key key,
    this.text,
    this.isFocused = false,
  }) : super(key: key);

  final String text;
  bool isFocused;
  _CustomPageButton state;

  @override
  _CustomPageButton createState() {
    state = _CustomPageButton();
    return state;
  }
}

class _CustomPageButton extends State<CustomPageButton> {

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
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        highlightColor: Color(StaticColors.deepSpaceSparkle),
        color: widget.isFocused
            ? Color(StaticColors.deepSpaceSparkle)
            : Color(StaticColors.lighterSlateGray),
        elevation: widget.isFocused ? 10 : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
                color: widget.isFocused ? Colors.black : Colors.black12)),
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: new GradientText(
          widget.text,
          style: TextStyle(color: Color(StaticColors.white)),
          gradient: new LinearGradient(
            colors: [lightPeach, darkPeach],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
