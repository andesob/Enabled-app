import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard-backspace-key.dart';
import 'package:enabled_app/keyboard_page/keyboard-capslock-key.dart';
import 'package:enabled_app/keyboard_page/keyboard-dictionary-key.dart';
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
  int rowFocused = 0;

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
  List<List<String>> allLetters = [];
  List<List<KeyboardKey>> allButtons = [];

  @override
  void initState() {
    super.initState();

    allLetters.add(firstRow);
    allLetters.add(secondRow);
    allLetters.add(thirdRow);
    allLetters.add(fourthRow);
    allLetters.add(fifthRow);
  }

  void _onCapslockHandler() {
    setState(() {
      isUpperCase ? toLowerCase() : toUpperCase();
    });
  }

  void toUpperCase() {
    for (int i = 0; i < allLetters.length; i++) {
      for (int j = 0; j < allLetters[i].length; j++) {
        allLetters[i][j] = allLetters[i][j].toUpperCase();
      }
    }

    isUpperCase = true;
  }

  void toLowerCase() {
    for (int i = 0; i < allLetters.length; i++) {
      for (int j = 0; j < allLetters[i].length; j++) {
        allLetters[i][j] = allLetters[i][j].toLowerCase();
      }
    }

    isUpperCase = false;
  }

  @override
  Widget build(BuildContext context) {
    allButtons = [];
    return Container(
      color: Color(StaticColors.apricot),
      child: Column(
        // <-- Column
        children: buildKeyboard(),
      ),
    );
  }

  List<Widget> buildKeyboard() {
    for (int i = 0; i < allLetters.length; i++) {
      allButtons.add(allLetters[i].map(
            (letter) {
          return new KeyboardKey(
            text: letter,
            onTextInput: _textInputHandler,
          );
        },
      ).toList());
    }

    List<Widget> keyboard = [];

    for (int i = 0; i < allButtons.length; i++) {
      keyboard.add(buildRows(i));
    }

    keyboard.add(buildBottomRow());

    return keyboard;
  }

  Expanded buildRows(i) {
    if (rowFocused == i) {}
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: allButtons[i],
        ),
        decoration: BoxDecoration(
            border: Border.all(
                width: 5,
                color: rowFocused == i ? Color(StaticColors.patriarch) : Colors
                    .transparent)
        ),
      ),
    );
  }

  Expanded buildBottomRow() {
    return Expanded(
      child: Row(children: [
        KeyboardCapslockKey(
          onCapslock: _onCapslockHandler,
        ),
        KeyboardDictionaryKey(),
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
