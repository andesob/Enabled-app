import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_capslock_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_horizontal_list.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({
    Key key,
    this.onTextInput,
    this.onBackspace,
    this.onCapslock,
    this.currentFocusedVerticalListIndex,
    this.currentFocusedHorizontalListIndex,
    this.inHorizontalList,
  }) : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback onCapslock;
  final int currentFocusedVerticalListIndex;
  final int currentFocusedHorizontalListIndex;
  final bool inHorizontalList;

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);

  void _backSpaceHandler() => widget.onBackspace.call();

  bool isUpperCase = true;

  List<String> firstRow = [" ", "E", "A", "N", "L", "F"];
  List<String> secondRow = ["T", "O", "S", "D", "P", "B"];
  List<String> thirdRow = ["I", "R", "C", "G", "V", "J"];
  List<String> fourthRow = ["H", "U", "W", "K", "Q", "?"];
  List<String> fifthRow = ["M", "Y", "X", "Z", ",", "!"];
  List<String> lastRow = ["Caps", "Send", "Backspace"];

  List<KeyboardKey> firstKeyRow;
  List<KeyboardKey> secondKeyRow;
  List<KeyboardKey> thirdKeyRow;
  List<KeyboardKey> fourthKeyRow;
  List<KeyboardKey> fifthKeyRow;

  List<List<String>> allRows;
  List<List<KeyboardKey>> allKeyRows;

  List<KeyboardHorizontalList> verticalList;

  @override
  void initState() {
    super.initState();
    buildKeys();
    buildKeyboard();
  }

  void buildKeys() {
    verticalList = [];
    allRows = [];
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

/*
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // <-- Column
        children: buildKeyboard(),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    verticalList = [];
    return Container(
      child: Column(
        children: buildKeyboard(),
      ),
    );
  }

  List<Widget> buildKeyboard() {
    List<KeyboardHorizontalList> rows = [];
    for (int i = 0; i < allRows.length; i++) {
      if (i == widget.currentFocusedVerticalListIndex) {
        rows.add(buildRow(allRows[i], true));
      } else {
        rows.add(buildRow(allRows[i], false));
      }
    }

    if (widget.currentFocusedVerticalListIndex == allRows.length) {
      rows.add(buildLastRow(true));
    } else {
      rows.add(buildLastRow(false));
    }
    return rows;
  }

  KeyboardHorizontalList buildRow(List<String> rowList, bool isFocused) {
    KeyboardHorizontalList horizontalList = KeyboardHorizontalList(
      keyStringList: rowList,
      onTextInput: _textInputHandler,
      isFocused: isFocused,
      inHorizontalList: widget.inHorizontalList,
      currentFocusedKeyIndex: widget.currentFocusedHorizontalListIndex,
    );
    verticalList.add(horizontalList);
    return horizontalList;
  }

  KeyboardHorizontalList buildLastRow(bool isFocused) {
    KeyboardHorizontalList horizontalList = KeyboardHorizontalList(
      keyStringList: lastRow,
      onCapslock: _onCapslockHandler,
      onBackspace: _backSpaceHandler,
      isFocused: isFocused,
      inHorizontalList: widget.inHorizontalList,
      currentFocusedKeyIndex: widget.currentFocusedHorizontalListIndex,
      isLastRow: true,
    );
    verticalList.add(horizontalList);
    return horizontalList;
  }
}
