import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DictionaryItem extends StatefulWidget {
  DictionaryItem({
    Key key,
    this.text = "",
    this.onDictItemChosen,
    this.flex = 1,
  }) : super(key: key);
  final String text;
  final ValueSetter<String> onDictItemChosen;
  final int flex;

  DictionaryItemState createState() => DictionaryItemState();
}

class DictionaryItemState extends State<DictionaryItem> {


  @override
  Widget build(BuildContext context) {
    int flex = widget.flex;
    String text = widget.text;
    ValueSetter<String> onDictItemChosen = widget.onDictItemChosen;
    print(text);
    return Expanded(
      flex: flex,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Material(
            color: Color(StaticColors.lighterSlateGray),
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
