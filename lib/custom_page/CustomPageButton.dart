import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

// TODO Change the flatButton to raisedButton??
class CustomPageButton extends StatefulWidget {
  CustomPageButton({Key key, this.text}) : super(key: key);

  final String text;
  bool isFocused = false;
  _CustomPageButton state;

  @override
  _CustomPageButton createState() {
    state = _CustomPageButton();
    return state;
  }
}

class _CustomPageButton extends State<CustomPageButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setFocus();
    text = widget.text;
  }

  String text;
  void setFocus() {
    if (this.mounted) {
      setState(() {
        widget.isFocused = true;
      });
    } else {
      print("not mounted");
    }
  }

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
          highlightColor: widget.isFocused ? Colors.pink : Colors.purpleAccent,
          color: widget.isFocused
              ? Color(StaticColors.deepSpaceSparkle)
              : Color(StaticColors.lighterSlateGray),
          elevation: widget.isFocused ? 1 : 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color: widget.isFocused ? Colors.black : Colors.black12)),
          onPressed: () {},
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
          )),
    );
  }
}
