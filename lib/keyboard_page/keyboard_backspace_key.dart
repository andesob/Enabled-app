import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardBackspaceKey extends StatefulWidget {
  KeyboardBackspaceKey({
    Key key,
    this.icon,
    this.onBackspace,
    this.flex = 1,
    this.isFocused = false,
  }) : super(key: key);
  final Icon icon;
  final VoidCallback onBackspace;
  final int flex;
  final bool isFocused;

  KeyboardBackspaceKeyState createState() => KeyboardBackspaceKeyState();
}

class KeyboardBackspaceKeyState extends State<KeyboardBackspaceKey> {
  @override
  Widget build(BuildContext context) {
    int flex = widget.flex;
    Icon icon = widget.icon;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(widget.isFocused ? StaticColors.black : StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              //onBackspace != null ? onBackspace.call() : null
              widget.onBackspace?.call();
            },
            child: Container(
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
