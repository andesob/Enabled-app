import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardKey extends StatefulWidget {
  KeyboardKey({
    Key key,
    this.text,
    this.onTextInput,
    this.flex = 1,
    this.onFocused,
    this.isFocused = false,
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;
  final VoidCallback onFocused;
  final bool isFocused;

  KeyboardKeyState createState() => KeyboardKeyState();
}

class KeyboardKeyState extends State<KeyboardKey> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(widget.isFocused ? StaticColors.black : StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              widget.onTextInput?.call(widget.text);
            },
            child: Container(
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 24
                        : 12,
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
