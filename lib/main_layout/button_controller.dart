import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonController extends StatefulWidget {
  final GlobalKey<PageState> pageKey;

  ButtonController(
      {Key key, this.pageKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ButtonControllerState();
}

class ButtonControllerState extends State<ButtonController> {
  buttonIsPressed(int index) {
    if (index == 0) {
      widget.pageKey.currentState?.pushPressed();
    }
    if (index == 1) {
      widget.pageKey.currentState?.pullPressed();
    }
    if (index == 2) {
      widget.pageKey.currentState?.leftPressed();
    }
    if (index == 3) {
      widget.pageKey.currentState?.rightPressed();
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
