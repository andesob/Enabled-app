import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_dictionary_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_horizontal_list.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// Widget representing the keyboard
class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({
    Key key,
    this.onTextInput,
    this.onBackspace,
    this.onDictPressed,
    this.currentFocusedVerticalListIndex = 0,
    this.currentFocusedHorizontalListIndex = 0,
    this.inHorizontalList = false,
    this.inDictionary = false,
    this.allRows,
    this.onSend,
  }) : super(key: key);

  /// Method that returns the letter pressed
  final ValueSetter<String> onTextInput;

  /// Method that is triggered when backspace is pressed.
  final VoidCallback onBackspace;

  /// Method that is triggered when dictionary button is pressed.
  final VoidCallback onDictPressed;

  /// Method that is triggered when send is pressed.
  final VoidCallback onSend;

  /// Keeps track of what row is currently focused
  final int currentFocusedVerticalListIndex;

  /// Keeps track of what letter is currently focused
  final int currentFocusedHorizontalListIndex;

  /// Tells if the horizontal list is entered or not
  final bool inHorizontalList;

  /// Tells if the dictionary is entered or not
  final bool inDictionary;

  /// Two dimensional list that includes all the letters on the keyboard
  final List<List<String>> allRows;

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  void _textInputHandler(String text) => widget.onTextInput?.call(text);

  void _backSpaceHandler() => widget.onBackspace?.call();

  void _dictKeyHandler() => widget.onDictPressed?.call();

  void _onSendHandler() => widget.onSend?.call();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: buildKeyboard(),
      ),
    );
  }

  List<Widget> buildKeyboard() {
    List<KeyboardHorizontalList> rows = [];
    for (int i = 0; i < widget.allRows.length; i++) {
      ///True if list is focused, false if not
      if (widget.currentFocusedVerticalListIndex == i && !widget.inDictionary) {
        rows.add(buildRow(widget.allRows[i], true));
      } else {
        rows.add(buildRow(widget.allRows[i], false));
      }
    }

    /// True if list is focused, false if not
    if (widget.currentFocusedVerticalListIndex == widget.allRows.length && !widget.inDictionary) {
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
    return horizontalList;
  }

  KeyboardHorizontalList buildLastRow(bool isFocused) {
    KeyboardHorizontalList horizontalList = KeyboardHorizontalList(
      onDictPressed: _dictKeyHandler,
      onBackspace: _backSpaceHandler,
      onSend: _onSendHandler,
      isFocused: isFocused,
      inHorizontalList: widget.inHorizontalList,
      currentFocusedKeyIndex: widget.currentFocusedHorizontalListIndex,
      isLastRow: true,
    );
    return horizontalList;
  }
}
