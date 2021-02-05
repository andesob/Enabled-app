import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/custom-keyboard.dart';
import 'package:enabled_app/main_page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class KeyboardPage extends StatefulWidget {
  KeyboardPage({Key key}) : super(key: key);

  _KeyboardPageState createState() => _KeyboardPageState();
}

class _KeyboardPageState extends State<KeyboardPage> {
  TextEditingController _controller = TextEditingController();
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);

  bool darkmode = false;

  void _changeDarkmode() {
    setState(() {
      darkmode = !darkmode;
    });
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: GradientAppBar(
              gradient:
                  LinearGradient(colors: [appBarColorLight, appBarColorDark]),
              actions: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                      icon: Icon(Icons.accessible_forward),
                      color: Color(
                          darkmode ? StaticColors.black : StaticColors.white),
                      splashColor: Color(Colors.grey.value),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _changeDarkmode();
                      }),
                )
              ],
            ),
          ),
          body: ListView(
            children: [
              CustomKeyboard(
                onTextInput: (myText) {
                  _insertText(myText);
                },
              ),
              TextField(
                controller: _controller,
              )
            ],
          )),
    );
  }
}
