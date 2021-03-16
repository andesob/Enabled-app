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
  KeyboardPage({Key key, this.title}) : super(key: key);

  final String title;

  _KeyboardPageState createState() => _KeyboardPageState();
}

class _KeyboardPageState extends PageState<KeyboardPage> {
  TextEditingController _controller = TextEditingController();
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);

  bool darkmode = false;

  void _changeDarkmode() {
    setState(() {
      darkmode = !darkmode;
    });
  }

  @override
  void initState() {
    super.initState();
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
    return Container(
      child: Scaffold(
        backgroundColor: darkmode ? Color(StaticColors.onyx) : Colors.white,
        appBar: MyAppBar(title: widget.title,),
        body: Column(
            children: [
          Container(
            child: TextField(
              controller: _controller,
              readOnly: true,
              showCursor: true,
              autofocus: true,
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
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
            child: Row(children: [
              Expanded(
                flex: 3,
                child: CustomKeyboard(
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
            ]),
          ),
        ]),
        bottomNavigationBar: ButtonController(),
      ),
    );
  }

  @override
  void leftPressed() {
    // TODO: implement leftPressed
  }

  @override
  void pullPressed() {
    // TODO: implement pullPressed
  }

  @override
  void pushPressed() {
    // TODO: implement pushPressed
  }

  @override
  void rightPressed() {
    // TODO: implement rightPressed
  }
}
