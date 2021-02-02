import 'dart:core';

import 'package:enabled_app/Contacts/contacts.dart';
import 'package:flutter/material.dart';

class MainPageButton extends StatelessWidget {
  String text;

  MainPageButton(String text) {
    this.text = text;
  }

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
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
      ),
      child: FlatButton(
        highlightColor: Color(0xffffff),
        child: new Text(text),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => contacts()),
        );},
      ),
    );
  }
}
