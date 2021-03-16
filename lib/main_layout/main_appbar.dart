import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:enabled_app/main_layout/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hasDropDown;

  const MyAppBar({Key key, this.title, this.hasDropDown = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class MyAppBarState extends State<MyAppBar> {

  createDropDown() {
    return <Widget>[
      Material(
        type: MaterialType.transparency,
        child: PopupMenuButton(
          icon: Icon(
            Icons.accessible_forward,
          ),
          itemBuilder: (BuildContext bc) =>
          [
            PopupMenuItem(child: Text("Dark Mode"), value: 0),
            PopupMenuItem(
                child: Text("Change Emergency Contact"), value: 1),
          ],
          onSelected: (selected) {
            if (selected == 0) {
              null;
            }
            if (selected == 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EmergencyPopup();
                  });
            }
          },
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery
        .of(context)
        .orientation == Orientation.portrait;
    return PreferredSize(
      preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
      child: GradientAppBar(
        title: Text(widget.title),
        gradient: LinearGradient(colors: [
          Color(StaticColors.lightPeach),
          Color(StaticColors.darkPeach)
        ]),
        actions: widget.hasDropDown ? createDropDown() : null,
      ),
    );
  }
}

