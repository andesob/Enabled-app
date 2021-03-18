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
    this.allRows
  }) : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback onCapslock;
  final int currentFocusedVerticalListIndex;
  final int currentFocusedHorizontalListIndex;
  final bool inHorizontalList;
  final List<List<String>> allRows;

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);

  void _backSpaceHandler() => widget.onBackspace.call();

  bool isUpperCase = true;
  List<String> lastRow = ["Caps", "Send", "Backspace"];

  List<KeyboardKey> firstKeyRow;
  List<KeyboardKey> secondKeyRow;
  List<KeyboardKey> thirdKeyRow;
  List<KeyboardKey> fourthKeyRow;
  List<KeyboardKey> fifthKeyRow;
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
    allKeyRows = [];

    for (List<String> row in widget.allRows) {
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
    for (int i = 0; i < widget.allRows.length; i++) {
      if (i == widget.currentFocusedVerticalListIndex) {
        rows.add(buildRow(widget.allRows[i], true));
      } else {
        rows.add(buildRow(widget.allRows[i], false));
      }
    }

    if (widget.currentFocusedVerticalListIndex == widget.allRows.length) {
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
      onCapslock: widget.onCapslock,
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
