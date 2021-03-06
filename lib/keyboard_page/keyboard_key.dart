import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Widget representing a single key on the keyboard
class KeyboardKey extends StatefulWidget {
  KeyboardKey({
    Key key,
    this.text,
    this.onTextInput,
    this.flex = 1,
    this.onPressed,
    this.isFocused = false,
  }) : super(key: key);

  /// Text displayed on the button
  final String text;

  /// Method called when button is pressed
  final ValueSetter<String> onTextInput;

  final int flex;

  /// Method called when button is pressed
  final VoidCallback onPressed;

  /// True if button is focused
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
              widget.onPressed?.call();
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
