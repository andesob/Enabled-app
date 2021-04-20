import 'package:csv/csv.dart';
import 'package:enabled_app/keyboard_page/dictionary_item.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CustomDictionary extends StatefulWidget {
  CustomDictionary({Key key, this.onDictItemChosen, this.text});

  final ValueSetter<String> onDictItemChosen;
  final String text;

  CustomDictionaryState createState() => CustomDictionaryState();
}

class CustomDictionaryState extends State<CustomDictionary> {
  void _onDictChosenHandler(String text) => widget.onDictItemChosen.call(text);
  List<String> dictionary = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/data/words_no.csv");
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
    dictionary = _listData.map((e) {
      return e[0].toString();
    }).toList();
    setState(() {
      ///      dictionary = _listData.cast<String>();
    });
  }

  List<String> _searchList(String searchKey) {
    List<String> hitList = [];
    for (String word in dictionary) {
      if (word.contains(searchKey.toLowerCase())) {
        hitList.add(word);
      }
    }

    if(dictionary.isEmpty || dictionary == null){
      return dictionary;
    }

    if (hitList.isEmpty) {
      return dictionary.sublist(0, 4);
    } else {
      if (hitList.length < 4) {
        return hitList.sublist(0, hitList.length);
      } else {
        return hitList.sublist(0, 4);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  String getLastWord() {
    if (widget.text.isNotEmpty) {
      List<String> words = widget.text.split(" ");
      return words.last;
    } else {
      return (" ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _searchList(getLastWord())
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
