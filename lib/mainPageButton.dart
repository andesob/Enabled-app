import 'package:flutter/material.dart';

class MainPageButton extends StatelessWidget{
  String text;

  MainPageButton(String text){
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);


    return Container(
      margin: EdgeInsets.all(20),
      width: 100,
      height: 100,
      decoration: new BoxDecoration(
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