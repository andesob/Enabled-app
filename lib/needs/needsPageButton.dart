import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeedsPageButton extends StatelessWidget {
  String text;

  //TODO
  //var picture;

  NeedsPageButton(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0x80ffecd2);
    const Color darkPeach = Color(0x80fcb7a0);

    return Row(
      children: [
        Flexible(
            child: new Container(
              margin: EdgeInsets.all(20),
              decoration: new BoxDecoration(
                image: DecorationImage(image: AssetImage('images/flutterimgtest.jpg'),
                fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: new LinearGradient(
                  colors: [lightPeach, darkPeach],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: new Container(
                width: 400,
                height: 400,
                child: new Text(
                  text,
                  style: TextStyle(color: Color(0xffffffff)),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ))
      ],
    );
  }
}
