import 'package:enabled_app/keyboard_page/keyboard-key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({Key key, this.onTextInput}) : super(key: key);

  final ValueSetter<String> onTextInput;

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.blue,
      child: Column( // <-- Column
        children: [
          buildRowOne(), // <-- Row
          buildRowTwo(), // <-- Row
          buildRowThree(), // <-- Row
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          KeyboardKey(
            text: '1',
            onTextInput: _textInputHandler,
          ),
          KeyboardKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          KeyboardKey(
            text: ' ',
            flex: 4,
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          KeyboardKey(
            text: ' ',
            flex: 4,
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

}