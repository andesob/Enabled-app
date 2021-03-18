import 'package:enabled_app/colors/colors.dart';
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
  bool focused = false;

  @override
  void initState() {
    super.initState();
    if (widget.text == " ") {
      setFocus();
    }
  }

  setFocus() {
    setState(() {
      focused = true;
      widget.onFocused?.call();
    });
  }

  removeFocus() {
    setState(() {
      focused = false;
    });
  }

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
          color: Color(widget.isFocused ? StaticColors.black : StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              onTextInput?.call(text);
            },
            child: Container(
              child: Center(
                child: Text(
                  text,
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
