import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DictionaryItem extends StatefulWidget {
  DictionaryItem({
    Key key,
    this.text = "",
    this.onDictItemChosen,
    this.flex = 1,
    this.isFocused = false,
  }) : super(key: key);
  final String text;
  final ValueSetter<String> onDictItemChosen;
  final int flex;
  final bool isFocused;

  DictionaryItemState createState() => DictionaryItemState();
}

class DictionaryItemState extends State<DictionaryItem> {


  @override
  Widget build(BuildContext context) {
    int flex = widget.flex;
    String text = widget.text.toUpperCase();
    ValueSetter<String> onDictItemChosen = widget.onDictItemChosen;
    return Expanded(
      flex: flex,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Material(
            color: Color(widget.isFocused
                ? StaticColors.black
                : StaticColors.lighterSlateGray),
            child: InkWell(
              onTap: () {
                onDictItemChosen?.call(text);
              },
              child: Container(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
