import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard-backspace-key.dart';
import 'package:enabled_app/keyboard_page/keyboard-capslock-key.dart';
import 'package:enabled_app/keyboard_page/keyboard-key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({Key key, this.onTextInput, this.onBackspace, this.onCapslock})
      : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback onCapslock;

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);

  void _backSpaceHandler() => widget.onBackspace.call();

  bool isUpperCase = true;

  List<String> firstRow = [" ", "E", "A", "N", "L", "F"];
  List<String> secondRow = [
    "T",
    "O",
    "S",
    "D",
    "P",
    "B",
  ];
  List<String> thirdRow = [
    "I",
    "R",
    "C",
    "G",
    "V",
    "J",
  ];
  List<String> fourthRow = ["H", "U", "W", "K", "Q", "?"];
  List<String> fifthRow = ["M", "Y", "X", "Z", ",", "!"];

  void _onCapslockHandler() {
    setState(() {
      isUpperCase ? toLowerCase() : toUpperCase();
    });
  }

  void toUpperCase() {
    for (int i = 0; i < firstRow.length; i++) {
      firstRow[i] = firstRow[i].toUpperCase();
    }
    for (int i = 0; i < secondRow.length; i++) {
      secondRow[i] = secondRow[i].toUpperCase();
    }
    for (int i = 0; i < thirdRow.length; i++) {
      thirdRow[i] = thirdRow[i].toUpperCase();
    }
    for (int i = 0; i < fourthRow.length; i++) {
      fourthRow[i] = fourthRow[i].toUpperCase();
    }
    for (int i = 0; i < fifthRow.length; i++) {
      fifthRow[i] = fifthRow[i].toUpperCase();
    }

    isUpperCase = true;
  }

  void toLowerCase() {
    for (int i = 0; i < firstRow.length; i++) {
      firstRow[i] = firstRow[i].toLowerCase();
    }
    for (int i = 0; i < secondRow.length; i++) {
      secondRow[i] = secondRow[i].toLowerCase();
    }
    for (int i = 0; i < thirdRow.length; i++) {
      thirdRow[i] = thirdRow[i].toLowerCase();
    }
    for (int i = 0; i < fourthRow.length; i++) {
      fourthRow[i] = fourthRow[i].toLowerCase();
    }
    for (int i = 0; i < fifthRow.length; i++) {
      fifthRow[i] = fifthRow[i].toLowerCase();
    }

    isUpperCase = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(StaticColors.apricot),
      child: Column(
        // <-- Column
        children: [
          buildRowOne(), // <-- Row
          buildRowTwo(), // <-- Row
          buildRowThree(),
          buildRowFour(),
          buildRowFive(), // <-- Row
          buildRowSix(),
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: firstRow
            .map(
              (letter) => new KeyboardKey(
                text: letter,
                onTextInput: _textInputHandler,
              ),
            )
            .toList(),
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: secondRow
            .map(
              (letter) => new KeyboardKey(
                text: letter,
                onTextInput: _textInputHandler,
              ),
            )
            .toList(),
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: thirdRow
            .map(
              (letter) => new KeyboardKey(
                text: letter,
                onTextInput: _textInputHandler,
              ),
            )
            .toList(),
      ),
    );
  }

  Expanded buildRowFour() {
    return Expanded(
      child: Row(
        children: fourthRow
            .map(
              (letter) => new KeyboardKey(
                text: letter,
                onTextInput: _textInputHandler,
              ),
            )
            .toList(),
      ),
    );
  }

  Expanded buildRowFive() {
    return Expanded(
      child: Row(
        children: fifthRow
            .map(
              (letter) => new KeyboardKey(
                text: letter,
                onTextInput: _textInputHandler,
              ),
            )
            .toList(),
      ),
    );
  }

  Expanded buildRowSix() {
    return Expanded(
      child: Row(children: [
        KeyboardCapslockKey(
          onCapslock: _onCapslockHandler,
        ),
        KeyboardKey(
          text: " ",
          onTextInput: _textInputHandler,
          flex: 4,
        ),
        KeyboardBackspaceKey(
          icon: Icon(
            Icons.backspace,
            color: Colors.white,
          ),
          onBackspace: _backSpaceHandler,
        ),
      ]),
    );
  }
}
