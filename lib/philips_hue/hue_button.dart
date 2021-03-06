import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

// TODO Change the flatButton to raisedButton??
class HuePageButton extends StatefulWidget {
  HuePageButton({Key key, this.text, this.onClick, this.isFocused = false}) : super(key: key);

  final String text;
  final VoidCallback onClick;
  final bool isFocused;

  @override
  _HuePageButtonState createState() => _HuePageButtonState();
}

class _HuePageButtonState extends State<HuePageButton> {
  String text;

  @override
  void initState() {
    super.initState();
    text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * (0.35),
      height: MediaQuery.of(context).size.width * (0.35),
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
        onPressed: () {
          widget.onClick.call();
        },
      ),
    );
  }
}
