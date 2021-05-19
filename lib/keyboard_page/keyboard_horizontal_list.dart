import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_dictionary_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Widget representing a horizontal list on the keyboard
class KeyboardHorizontalList extends StatefulWidget {
  KeyboardHorizontalList({
    Key key,
    this.keyStringList,
    this.isFocused = false,
    this.isLastRow = false,
    this.inHorizontalList = false,
    this.onTextInput,
    this.onBackspace,
    this.onDictPressed,
    this.currentFocusedKeyIndex = 0,
    this.onSend,
  }) : super(key: key);

  /// The list containing all strings in the row
  final List<String> keyStringList;

  /// True if list is focused
  final bool isFocused;

  /// True if last row
  final bool isLastRow;

  /// True if inside horizontal list
  final bool inHorizontalList;

  /// Keeps track of the current item in the list focused
  final int currentFocusedKeyIndex;

  /// Method that returns the letter on the button pressed
  final ValueSetter<String> onTextInput;

  /// Method called when backspace is pressed
  final VoidCallback onBackspace;

  /// Method called when dictionary button is pressed
  final VoidCallback onDictPressed;

  /// Method called when send button is pressed
  final VoidCallback onSend;

  @override
  _KeyboardHorizontalList createState() => _KeyboardHorizontalList();
}

class _KeyboardHorizontalList extends State<KeyboardHorizontalList> {
  void _textInputHandler(String text) => widget.onTextInput?.call(text);

  void _backSpaceHandler() => widget.onBackspace?.call();

  void _dictKeyHandler() => widget.onDictPressed?.call();

  void _onSendHandler() => widget.onSend?.call();

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
            KeyboardDictionaryKey(
              onDictPressed: _dictKeyHandler,
              isFocused: capsLockKeyFocused(),
            ),
            KeyboardKey(
              text: "Send",
              isFocused: sendKeyFocused(),
              onPressed: _onSendHandler,
            ),
            KeyboardBackspaceKey(
              icon: Icon(
                Icons.backspace,
                color: Colors.white,
              ),
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
