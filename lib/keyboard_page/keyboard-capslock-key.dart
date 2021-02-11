import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardCapslockKey extends StatefulWidget {
  KeyboardCapslockKey({Key key, this.onCapslock, this.flex = 1});

  final VoidCallback onCapslock;
  final int flex;

  KeyboardCapslockKeyState createState() => KeyboardCapslockKeyState();
}

class KeyboardCapslockKeyState extends State<KeyboardCapslockKey> {
  @override
  Widget build(BuildContext context) {
    int flex = widget.flex;
    VoidCallback onCapslock = widget.onCapslock;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              //onCapslock != null ? onCapslock.call() : null
              onCapslock?.call();
            },
            child: Container(
              child: Center(
                  child: Icon(
                Icons.apps,
                color: Colors.white,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
