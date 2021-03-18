import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_capslock_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
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

  List<KeyboardKey> firstKeyRow;
  List<KeyboardKey> secondKeyRow;
  List<KeyboardKey> thirdKeyRow;
  List<KeyboardKey> fourthKeyRow;
  List<KeyboardKey> fifthKeyRow;

  List<List<KeyboardKey>> allKeyRows;

  @override
  void initState() {
    super.initState();
    buildKeys();
  }

  void buildKeys() {
    List<List<String>> allRows = [];
    allRows.add(firstRow);
    allRows.add(secondRow);
    allRows.add(thirdRow);
    allRows.add(fourthRow);
    allRows.add(fifthRow);

    allKeyRows = [];

    for (List<String> row in allRows) {
      List<KeyboardKey> keyRow = row
          .map(
            (letter) => new KeyboardKey(
              text: letter,
              onTextInput: _textInputHandler,
            ),
          )
          .toList();
      allKeyRows.add(keyRow);
    }
  }

  void _onCapslockHandler() {
    setState(() {
      isUpperCase ? toLowerCase() : toUpperCase();
    });
  }

  void toUpperCase() {
    for (List<KeyboardKey> row in allKeyRows) {
      for (KeyboardKey key in row) {}
    }

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
    buildKeys();
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

    buildKeys();
    isUpperCase = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // <-- Column
        children: buildKeyboard(),
      ),
    );
  }

  List<Widget> buildKeyboard() {
    List<Expanded> rows = [];
    for (List<KeyboardKey> row in allKeyRows) {
      rows.add(buildRow(row));
    }
    rows.add(buildLastRow());
    return rows;
  }

  Expanded buildRow(List<KeyboardKey> rowList) {
    return Expanded(
      child: Row(
        children: rowList,
      ),
    );
  }

  Expanded buildLastRow() {
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
