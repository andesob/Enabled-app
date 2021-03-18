import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:enabled_app/keyboard_page/custom_dictionary.dart';
import 'package:enabled_app/keyboard_page/custom_keyboard.dart';
import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_capslock_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class KeyboardHorizontalList extends StatefulWidget {
  KeyboardHorizontalList({
    Key key,
    this.keyStringList,
    this.isFocused = false,
    this.isLastRow = false,
    this.inHorizontalList = false,
    this.onTextInput,
    this.onBackspace,
    this.onCapslock,
    this.currentFocusedKeyIndex = 0,
  }) : super(key: key);

  final List<String> keyStringList;
  final bool isFocused;
  final bool isLastRow;
  final bool inHorizontalList;
  final int currentFocusedKeyIndex;
  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback onCapslock;

  @override
  _KeyboardHorizontalList createState() => _KeyboardHorizontalList();
}

class _KeyboardHorizontalList extends State<KeyboardHorizontalList> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);

  void _backSpaceHandler() => widget.onBackspace.call();

  void _capsLockHandler() => widget.onCapslock.call();

  @override
  Widget build(BuildContext context) {
    if (widget.isLastRow) {
      return buildLastRow();
    } else {
      return buildRows();
    }
  }

  Expanded buildRows() {
    return Expanded(
      flex: 1,
      child: Container(
        color: widget.isFocused ? Colors.black : Colors.white,
        child: Row(
          children: widget.keyStringList.map(
            (text) {
              bool focused = widget.isFocused &&
                  widget.inHorizontalList &&
                  widget.currentFocusedKeyIndex ==
                      widget.keyStringList.indexOf(text);
              return KeyboardKey(
                text: text,
                onTextInput: _textInputHandler,
                isFocused: focused,
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Expanded buildLastRow() {
    return Expanded(
      flex: 1,
      child: Container(
        color: widget.isFocused ? Colors.black : Colors.white,
        child: Row(
          children: [
            KeyboardCapslockKey(
              onCapslock: _capsLockHandler,
              isFocused: capsLockKeyFocused(),
            ),
            KeyboardKey(
              text: "Send",
              isFocused: sendKeyFocused(),
            ),
            KeyboardBackspaceKey(
              icon: Icon(Icons.backspace),
              onBackspace: _backSpaceHandler,
              isFocused: backSpaceKeyFocused(),
            ),
          ],
        ),
      ),
    );
  }

  bool capsLockKeyFocused() {
    return widget.isFocused &&
        widget.inHorizontalList &&
        widget.currentFocusedKeyIndex == 0;
  }

  bool sendKeyFocused() {
    return widget.isFocused &&
        widget.inHorizontalList &&
        widget.currentFocusedKeyIndex == 1;
  }

  bool backSpaceKeyFocused() {
    return widget.isFocused &&
        widget.inHorizontalList &&
        widget.currentFocusedKeyIndex == 2;
  }
}
