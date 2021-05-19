import 'package:enabled_app/keyboard_page/dictionary_item.dart';
import 'package:flutter/cupertino.dart';

/// Widget representing the dictionary
class CustomDictionary extends StatefulWidget {
  CustomDictionary({
    Key key,
    this.onDictItemChosen,
    this.text,
    this.isFocused = false,
    this.currentFocusedVerticalListIndex = 0,
    this.dictionary,
  });

  /// Method to return the word chosen
  final ValueSetter<String> onDictItemChosen;

  /// Text to be displayed
  final String text;

  /// True if dictionary is focused
  final bool isFocused;

  /// Keeps track of what dictionary item currently focused
  final int currentFocusedVerticalListIndex;

  /// List of all strings inside dictionary
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
