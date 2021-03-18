import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/custom_keyboard.dart';
import 'package:enabled_app/keyboard_page/custom_dictionary.dart';
import 'package:enabled_app/main_page/home_page.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/main_layout/button_controller.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class KeyboardPage extends StatefulWidget {
  KeyboardPage({
    Key key,
    this.title,
    this.pageKey,
  }) : super(key: key);

  final String title;
  final GlobalKey<PageState> pageKey;

  _KeyboardPageState createState() => _KeyboardPageState();
}

class _KeyboardPageState extends PageState<KeyboardPage> {
  TextEditingController _controller = TextEditingController();
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);

  int currentFocusedVerticalListIndex;
  int currentFocusedHorizontalListIndex;
  bool inHorizontalList = false;

  bool darkmode = false;

  void _changeDarkmode() {
    setState(() {
      darkmode = !darkmode;
    });
  }

  void _inHorizontalListHandle() {
    setState(() {
      inHorizontalList = !inHorizontalList;
    });
  }

  @override
  void initState() {
    super.initState();

    currentFocusedHorizontalListIndex = 0;
    currentFocusedVerticalListIndex = 0;
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _onBackspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  void _onDictItemChosen(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: TextField(
          controller: _controller,
          readOnly: true,
          showCursor: true,
          autofocus: true,
          style: TextStyle(
            fontSize: MediaQuery.of(context).orientation == Orientation.portrait
                ? 24
                : 12,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(StaticColors.greenSheen),
          ),
        ),
      ),
      Expanded(
        flex: 9,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomKeyboard(
                currentFocusedVerticalListIndex:
                    currentFocusedVerticalListIndex,
                currentFocusedHorizontalListIndex:
                    currentFocusedHorizontalListIndex,
                inHorizontalList: inHorizontalList,
                onBackspace: _onBackspace,
                onTextInput: (myText) {
                  _insertText(myText);
                },
              ),
            ),
            Expanded(
              child: CustomDictionary(
                onDictItemChosen: _onDictItemChosen,
              ),
              flex: 1,
            )
          ],
        ),
      ),
    ]);
  }

  @override
  void leftPressed() {
    setState(() {
      if (inHorizontalList) {
        if (currentFocusedVerticalListIndex == 5) {
          if (currentFocusedHorizontalListIndex != 0) {
            currentFocusedHorizontalListIndex -= 1;
          } else {
            currentFocusedHorizontalListIndex = 2;
          }
        } else {
          if (currentFocusedHorizontalListIndex != 0) {
            currentFocusedHorizontalListIndex -= 1;
          } else {
            currentFocusedHorizontalListIndex = 5;
          }
        }
      } else {
        if (currentFocusedVerticalListIndex != 0) {
          currentFocusedVerticalListIndex -= 1;
        } else{
          currentFocusedVerticalListIndex = 5;
        }
      }
    });
  }

  @override
  void pullPressed() {
    setState(() {
      if (inHorizontalList) {
        inHorizontalList = !inHorizontalList;
      }
    });
  }

  @override
  void pushPressed() {
    setState(() {
      if (!inHorizontalList) {
        inHorizontalList = !inHorizontalList;
      }
    });
  }

  @override
  void rightPressed() {
    setState(() {
      //If user has entered a horizontal list
      if (inHorizontalList) {
        //If bottom row is in focus
        if (currentFocusedVerticalListIndex == 5) {
          //Move right if not at the last element in the bottom row
          if (currentFocusedHorizontalListIndex != 2) {
            currentFocusedHorizontalListIndex += 1;
          } else {
            currentFocusedHorizontalListIndex = 0;
          }
        }
        //If not at the bottom row
        else {
          //Move right if not at last element in the row
          if (currentFocusedHorizontalListIndex != 5) {
            currentFocusedHorizontalListIndex += 1;
          } else {
            currentFocusedHorizontalListIndex = 0;
          }
        }
      } else {
        if (currentFocusedVerticalListIndex != 5) {
          currentFocusedVerticalListIndex += 1;
        } else {
          currentFocusedVerticalListIndex = 0;
        }
      }
    });
  }
}
