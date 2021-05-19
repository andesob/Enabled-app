import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Widget that represents the backspace key
class KeyboardBackspaceKey extends StatefulWidget {
  KeyboardBackspaceKey({
    Key key,
    this.icon,
    this.onBackspace,
    this.flex = 1,
    this.isFocused = false,
  }) : super(key: key);

  /// The icon of the key
  final Icon icon;

  /// Method that is called when button is pressed
  final VoidCallback onBackspace;

  final int flex;

  /// True if button is focused
  final bool isFocused;

  KeyboardBackspaceKeyState createState() => KeyboardBackspaceKeyState();
}

class KeyboardBackspaceKeyState extends State<KeyboardBackspaceKey> {
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
              //onBackspace != null ? onBackspace.call() : null
              widget.onBackspace?.call();
            },
            child: Container(
              child: Center(child: widget.icon),
            ),
          ),
        ),
      ),
    );
  }
}
