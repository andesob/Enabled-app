import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardDictionaryKey extends StatefulWidget {
  KeyboardDictionaryKey({
    Key key,
    this.onDictPressed,
    this.flex = 1,
    this.isFocused = false,
  }) : super(key: key);

  final VoidCallback onDictPressed;
  final int flex;
  final bool isFocused;

  KeyboardDictionaryKeyState createState() => KeyboardDictionaryKeyState();
}

class KeyboardDictionaryKeyState extends State<KeyboardDictionaryKey> {
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
              widget.onDictPressed?.call();
            },
            child: Container(
              child: Center(
                child: Icon(
                  Icons.list,
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
