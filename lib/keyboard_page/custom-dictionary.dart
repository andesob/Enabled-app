import 'package:enabled_app/keyboard_page/dictionary-item.dart';
import 'package:flutter/cupertino.dart';

class CustomDictionary extends StatefulWidget {
  CustomDictionary({Key key, this.onDictItemChosen});

  final ValueSetter<String> onDictItemChosen;

  CustomDictionaryState createState() => CustomDictionaryState();
}

class CustomDictionaryState extends State<CustomDictionary> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      child: Column(
        children: [
          DictionaryItem(),
        ],
      ),
    );
  }
}
