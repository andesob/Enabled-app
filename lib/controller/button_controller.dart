import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonController extends StatefulWidget {

  ButtonController({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ButtonControllerState();
}

class ButtonControllerState extends State<ButtonController> {
  buttonIsPressed(int index){
    if (index == 0) {
      print("Up");
    }
    if (index == 1) {
      print("Down");
    }
    if (index == 2) {
      print("Enter");
    }
    if(index == 3){
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: buttonIsPressed,
      unselectedItemColor: Color(StaticColors.lighterSlateGray),
      selectedItemColor: Color(StaticColors.lighterSlateGray),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'Up',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Down',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Enter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.backup),
          label: 'Go Back',
        )
      ],
    );
  }
}
