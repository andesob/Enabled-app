import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonController extends StatefulWidget {
  final VoidCallback onPush;
  final VoidCallback onPull;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  ButtonController(
      {Key key, this.onPush, this.onPull, this.onLeft, this.onRight})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ButtonControllerState();
}

class ButtonControllerState extends State<ButtonController> {
  buttonIsPressed(int index) {
    if (index == 0) {
      widget.onPush.call();
    }
    if (index == 1) {
      widget.onPull.call();
    }
    if (index == 2) {
      widget.onLeft.call();
    }
    if (index == 3) {
      widget.onRight.call();
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
          label: 'Push',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Pull',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Left',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.backup),
          label: 'Right',
        ),
      ],
    );
  }
}
