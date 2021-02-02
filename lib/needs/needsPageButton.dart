import 'dart:ui';

import 'package:flutter/cupertino.dart';

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
      child: new BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),

      ),
    );
  }
}
