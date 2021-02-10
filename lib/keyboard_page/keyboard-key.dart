import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardKey extends StatefulWidget {
  KeyboardKey({
    Key key,
    this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);
  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;

  KeyboardKeyState createState() => KeyboardKeyState();
}

class KeyboardKeyState extends State<KeyboardKey> {
  @override
  Widget build(BuildContext context) {
    int flex = widget.flex;
    String text = widget.text;
    ValueSetter<String> onTextInput = widget.onTextInput;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              onTextInput?.call(text);
            },
            child: Container(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
