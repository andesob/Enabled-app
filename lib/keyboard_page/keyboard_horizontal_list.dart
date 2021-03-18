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

  _KeyboardVerticaList state;

  @override
  _KeyboardVerticaList createState() {
    state = _KeyboardVerticaList();
    return state;
  }
}

class _KeyboardVerticaList extends State<KeyboardHorizontalList> {
  void _textInputHandler(String text) => widget.onTextInput.call(text);

  void _backSpaceHandler() => widget.onBackspace.call();

  void _capsLockHandler() => widget.onCapslock.call();

  int listIndex = 0;
  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;
  int lastScrollIndex = 0;
  KeyboardKey currentFocusKey;

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController scrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  /// Sets the focus around this list.
  /*void setFocus() {
    if (this.mounted) {
      setState(() {
        widget.isFocused = true;
      });
    } else {
      print("not mounted");
    }
  }

  /// Removes the focus of this list.
  void removeFocus() {
    setState(() {
      widget.isFocused = false;
    });
  }

  /// Scrolls the list to the right of the screen if possible.
  void scrollRight() {
    if (listIndex < widget.keyStringList.length - 1) {
      listIndex++;
      if (canScrollRight()) {
        lastScrollIndexRight = listIndex;
        lastScrollIndex = listIndex;
        print("last scroll right :" + lastScrollIndexRight.toString());
        scrollController.scrollTo(
            index: listIndex,
            duration: Duration(
              seconds: 1,
            ),
            alignment: 0.75,
            curve: Curves.ease);
      }
    }
    this.setButtonFocus();
  }

  /// Scrolls the list to the left of the screen if possible.
  void scrollLeft() {
    if (listIndex > 0) {
      listIndex--;
      if (canScrollLeft()) {
        lastScrollIndexLeft = listIndex;
        lastScrollIndex = listIndex;
        scrollController.scrollTo(
            index: listIndex,
            duration: Duration(
              seconds: 1,
            ),
            curve: Curves.ease);
      }
      this.setButtonFocus();
    }
  }

  /// Checks of the list can scroll to the right or not.
  /// Return true if it can scroll and false if it can't.
  bool canScrollRight() {
    bool canScroll = false;
    if (listIndex < widget.keyStringList.length && listIndex > 3) {
      if (listIndex > lastScrollIndexLeft + 3 && listIndex > lastScrollIndex) {
        canScroll = true;
      }
    }
    return canScroll;
  }

  /// Checks of the list can scroll to the left or not.
  /// Return true if it can scroll and false if it can't.
  bool canScrollLeft() {
    bool canScroll = false;
    if (listIndex < widget.keyStringList.length - 3) {
      if (lastScrollIndexRight != 0 && listIndex < lastScrollIndexRight - 3) {
        canScroll = true;
      }
    }
    return canScroll;
  }

  /// Sets the focus of a button.
  void setButtonFocus() {
    if (currentFocusKey == null) {
      currentFocusKey = widget.keyStringList[0];
      currentFocusKey = widget.keyStringList[listIndex];
      currentFocusKey.state.setFocus();
    } else {
      currentFocusKey.state.removeFocus();
      currentFocusKey = widget.keyStringList[listIndex];
      currentFocusKey.state.setFocus();
    }
  }

  /// Removes the focus of a button.
  void removeButtonFocus() {
    if (currentFocusKey != null) {
      currentFocusKey.state.removeFocus();
    }
  }*/

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
        color: widget.isFocused ? Colors.black : Colors.blue,
        child: Row(
          children: widget.keyStringList.map(
            (text) {
              bool focused = widget.isFocused &&
                  widget.inHorizontalList &&
                  widget.currentFocusedKeyIndex == widget.keyStringList.indexOf(text);
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
      child: Row(
        children: [
          KeyboardCapslockKey(
            onCapslock: _capsLockHandler,
          ),
          KeyboardKey(
            text: widget.keyStringList[1],
          ),
          KeyboardBackspaceKey(
            icon: Icon(Icons.backspace),
            onBackspace: _backSpaceHandler,
          ),
        ],
      ),
    );
  }
}
