import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/material.dart';

class MainPageButton extends StatelessWidget {
  String text;

  MainPageButton(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      margin: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
      ),
      child: FlatButton(
        child: new Text(text),
        onPressed: () {},
      ),
    );
  }
}
