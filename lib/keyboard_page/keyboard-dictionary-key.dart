import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardDictionaryKey extends StatefulWidget {
  KeyboardDictionaryKey({Key key, this.onDict, this.flex = 1});

  final VoidCallback onDict;
  final int flex;

  KeyboardDictionaryKeyState createState() => KeyboardDictionaryKeyState();
}

class KeyboardDictionaryKeyState extends State<KeyboardDictionaryKey> {
  @override
  Widget build(BuildContext context) {
    int flex = widget.flex;
    VoidCallback onDict = widget.onDict;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Color(StaticColors.lighterSlateGray),
          child: InkWell(
            onTap: () {
              //onDict != null ? onDict.call() : null
              onDict?.call();
            },
            child: Container(
              child: Center(
                  child: Icon(
                    Icons.list,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
