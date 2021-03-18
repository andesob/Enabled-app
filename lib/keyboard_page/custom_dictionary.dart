import 'package:csv/csv.dart';
import 'package:enabled_app/keyboard_page/dictionary_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CustomDictionary extends StatefulWidget {
  CustomDictionary({Key key, this.onDictItemChosen});

  final ValueSetter<String> onDictItemChosen;

  CustomDictionaryState createState() => CustomDictionaryState();
}

class CustomDictionaryState extends State<CustomDictionary> {
  void _onDictChosenHandler(String text) => widget.onDictItemChosen.call(text);
  List<String> dictionary = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/data/ord-norsk.csv");
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
    dictionary = _listData.map((e) {
      return e[0].toString();
    }).toList();
    print(dictionary);
    setState(() {
      ///      dictionary = _listData.cast<String>();
    });
  }

  List<String> _searchList(String searchKey){
    List<String> hitList = [];
    dictionary.forEach((word) {
      if(word.contains(searchKey)){
        hitList.add(word);
      }
    });
    if(hitList.isEmpty){
      return dictionary.sublist(0,4);
    }else{
      return hitList.sublist(0,4);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _searchList("")
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
