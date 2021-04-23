import 'package:csv/csv.dart';
import 'package:enabled_app/keyboard_page/dictionary_item.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../tts_controller.dart';

class CustomDictionary extends StatefulWidget {
  CustomDictionary({
    Key key,
    this.onDictItemChosen,
    this.text,
    this.isFocused = false,
    this.currentFocusedVerticalListIndex = 0,
    this.dictionary,
  });

  final ValueSetter<String> onDictItemChosen;
  final String text;
  final bool isFocused;
  final int currentFocusedVerticalListIndex;
  final List<String> dictionary;

  CustomDictionaryState createState() => CustomDictionaryState();
}

class CustomDictionaryState extends State<CustomDictionary> {
  void _onDictChosenHandler(String text) => widget.onDictItemChosen.call(text);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.dictionary
            .asMap().entries.map(
              (entry) => DictionaryItem(
                onDictItemChosen: _onDictChosenHandler,
                text: entry.value,
                isFocused: (entry.key == widget.currentFocusedVerticalListIndex) && widget.isFocused,
              ),
            )
            .toList(),
      ),
    );
  }
}
