import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardCapslockKey extends StatefulWidget {
  KeyboardCapslockKey({
    Key key,
    this.onCapslock,
    this.flex = 1,
    this.isFocused = false,
  }) : super(key: key);

  final VoidCallback onCapslock;
  final int flex;
  final bool isFocused;

  KeyboardCapslockKeyState createState() => KeyboardCapslockKeyState();
}

class KeyboardCapslockKeyState extends State<KeyboardCapslockKey> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(widget.isFocused
              ? StaticColors.black
              : StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              //onCapslock != null ? onCapslock.call() : null
              widget.onCapslock?.call();
            },
            child: Container(
              child: Center(
                child: Icon(
                  Icons.apps,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
