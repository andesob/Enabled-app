import 'package:enabled_app/keyboard_page/dictionary-item.dart';
import 'package:flutter/cupertino.dart';

class CustomDictionary extends StatefulWidget {
  CustomDictionary({Key key, this.onDictItemChosen});

  final ValueSetter<String> onDictItemChosen;

  CustomDictionaryState createState() => CustomDictionaryState();
}

class CustomDictionaryState extends State<CustomDictionary> {
  void _onDictChosenHandler(String text) => widget.onDictItemChosen.call(text);

  List<String> dictionary = ["Sunde", "Trymjjj", "Eskilet", "Anders"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: dictionary
            .map(
              (text) => DictionaryItem(
                onDictItemChosen: _onDictChosenHandler,
                text: text,
              ),
            )
            .toList(),
      ),
    );
  }
}
