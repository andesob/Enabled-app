import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/material.dart';

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
      child: RaisedButton(
        highlightColor: widget.isFocused ? Colors.pink : Colors.purpleAccent,
        color: widget.isFocused
            ? Colors.pink
            : Color(StaticColors.lighterSlateGray),
        elevation: widget.isFocused ? 0.5 : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: widget.isFocused ? Colors.black : Colors.black12)),
        onPressed: () {},
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Text(widget.text),
      ),
    );
  }
}
