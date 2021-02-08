import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeedsPageButton extends StatelessWidget {
  NeedsPageButton({Key key,this.text}) : super(key:key);
  final String text;

  //TODO
  //var picture;


  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);

    return Container(
        margin: EdgeInsets.all(20),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: new LinearGradient(
            colors: [lightPeach, darkPeach],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: new Column(
          children: [
            Flexible(
              child: new Container(
                child: new Image.asset('assets/images/justatest69.png'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: new Text(
                text,
                style: TextStyle(color: Color(0xffffffff)),
              ),
            ),
          ],
        ));
  }
}
