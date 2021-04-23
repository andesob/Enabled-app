import 'package:csv/csv.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/keyboard_page/custom_keyboard.dart';
import 'package:enabled_app/keyboard_page/custom_dictionary.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/main_layout/input_controller.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class KeyboardPage extends StatefulWidget {
  KeyboardPage({
    Key key,
  }) : super(key: key);

  _KeyboardPageState createState() => _KeyboardPageState();
}

class _KeyboardPageState extends PageState<KeyboardPage> {
  FlutterTts tts = TTSController().flutterTts;

  TextEditingController _controller = TextEditingController();

  int currentFocusedVerticalListIndex;
  int currentFocusedHorizontalListIndex;
  bool inHorizontalList = false;
  bool inDictionary = false;
  bool isUpperCase = true;

  List<String> firstRow = [" ", "E", "A", "N", "L", "F"];
  List<String> secondRow = ["T", "O", "S", "D", "P", "B"];
  List<String> thirdRow = ["I", "R", "C", "G", "V", "J"];
  List<String> fourthRow = ["H", "U", "W", "K", "Q", "?"];
  List<String> fifthRow = ["M", "Y", "X", "Z", ",", "!"];

  List<List<String>> allRows;

  List<String> dictionary = [];

  @override
  void initState() {
    super.initState();
    _loadCSV();
    currentFocusedHorizontalListIndex = 0;
    currentFocusedVerticalListIndex = 0;
    allRows = [];
    allRows.add(firstRow);
    allRows.add(secondRow);
    allRows.add(thirdRow);
    allRows.add(fourthRow);
    allRows.add(fifthRow);
  }

  void _insertText(String myText) {
    setState(() {
      final text = _controller.text;
      final newText = text + myText;
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
      _ttsSpeak(myText);
    });
  }

  void _onBackspace() {
    setState(() {
      final text = _controller.text;
      if (text.length == 0) {
        return;
      }
      _controller.text = text.substring(0, text.length - 1);
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
  }

  void _onDictItemChosen(String myText) {
    setState(() {
      final text = _controller.text;
      final textArray = text.split(" ");
      textArray.last = myText;
      String newText = "";
      for (String s in textArray) {
        newText += s + " ";
      }
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
      _ttsSpeak(myText);
    });
  }

  void _ttsSpeak(String s) {
    tts.speak(s);
  }

  void _onSendPressed() {
    _ttsSpeak(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Material(
          child: TextField(
            controller: _controller,
            readOnly: true,
            showCursor: true,
            autofocus: true,
            style: TextStyle(
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 24
                      : 12,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(StaticColors.greenSheen),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 9,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomKeyboard(
                allRows: allRows,
                currentFocusedVerticalListIndex:
                    currentFocusedVerticalListIndex,
                currentFocusedHorizontalListIndex:
                    currentFocusedHorizontalListIndex,
                inHorizontalList: inHorizontalList,
                inDictionary: inDictionary,
                onBackspace: _onBackspace,
                onDictPressed: _onDictKeyHandler,
                onSend: _onSendPressed,
                onTextInput: (myText) {
                  _insertText(myText);
                },
              ),
            ),
            Expanded(
              child: CustomDictionary(
                dictionary: _searchList(getLastWord()),
                onDictItemChosen: _onDictItemChosen,
                text: _controller.text,
                currentFocusedVerticalListIndex:
                    currentFocusedVerticalListIndex,
                isFocused: inDictionary,
              ),
              flex: 1,
            )
          ],
        ),
      ),
    ]);
  }

  @override
  void leftPressed() {
    setState(() {
      if (inHorizontalList) {
        if (currentFocusedVerticalListIndex == 5) {
          if (currentFocusedHorizontalListIndex != 0) {
            currentFocusedHorizontalListIndex -= 1;
          } else {
            currentFocusedHorizontalListIndex = 2;
          }
        } else {
          if (currentFocusedHorizontalListIndex != 0) {
            currentFocusedHorizontalListIndex -= 1;
          } else {
            currentFocusedHorizontalListIndex = 5;
          }
        }
      } else if (inDictionary) {
        if (currentFocusedVerticalListIndex == 0) {
          currentFocusedVerticalListIndex = 7;
        } else {
          currentFocusedVerticalListIndex--;
        }
      } else {
        if (currentFocusedVerticalListIndex != 0) {
          currentFocusedVerticalListIndex -= 1;
        } else {
          currentFocusedVerticalListIndex = 5;
        }
      }
    });
  }

  @override
  void pullPressed() {
    setState(() {
      if (inHorizontalList || inDictionary) {
        if (inDictionary) {
          currentFocusedVerticalListIndex = 0;
        }
        inDictionary = false;
        inHorizontalList = false;
        currentFocusedHorizontalListIndex = 0;
        return;
      }
      Navigator.pushReplacementNamed(context, Strings.HOME);
    });
  }

  @override
  void pushPressed() {
    setState(() {
      if (!inHorizontalList && !inDictionary) {
        inHorizontalList = true;
      } else if (inDictionary) {
        String s = _searchList(getLastWord())[currentFocusedVerticalListIndex];
        _onDictItemChosen(s.toUpperCase());
      } else {
        if (currentFocusedVerticalListIndex == 5) {
          //Caps lock is pressed
          if (currentFocusedHorizontalListIndex == 0) {
            _onDictKeyHandler();
          }
          //Send is pressed
          else if (currentFocusedHorizontalListIndex == 1) {
            _onSendPressed();
          }
          //Backspace is pressed
          else if (currentFocusedHorizontalListIndex == 2) {
            _onBackspace();
          }
        } else if (!inDictionary) {
          String letter = allRows[currentFocusedVerticalListIndex]
              [currentFocusedHorizontalListIndex];
          _insertText(letter);
        }
      }
    });
  }

  @override
  void rightPressed() {
    setState(() {
      //If user has entered a horizontal list
      if (inHorizontalList) {
        //If bottom row is in focus
        if (currentFocusedVerticalListIndex == 5) {
          //Move right if not at the last element in the bottom row
          if (currentFocusedHorizontalListIndex != 2) {
            currentFocusedHorizontalListIndex++;
          } else {
            currentFocusedHorizontalListIndex = 0;
          }
        }
        //If not at the bottom row
        else {
          //Move right if not at last element in the row
          if (currentFocusedHorizontalListIndex != 5) {
            currentFocusedHorizontalListIndex++;
          } else {
            currentFocusedHorizontalListIndex = 0;
          }
        }
      } else if (inDictionary) {
        if (currentFocusedVerticalListIndex == 7) {
          currentFocusedVerticalListIndex = 0;
        } else {
          currentFocusedVerticalListIndex++;
        }
      } else {
        if (currentFocusedVerticalListIndex != 5) {
          currentFocusedVerticalListIndex++;
        } else {
          currentFocusedVerticalListIndex = 0;
        }
      }
    });
  }

  void _onDictKeyHandler() {
    setState(() {
      inDictionary = !inDictionary;
      inHorizontalList = false;
      currentFocusedHorizontalListIndex = 0;
      currentFocusedVerticalListIndex = 0;
    });
  }

  void _loadCSV() async {
    String _rawData = null;
    if (TTSController().getCurrentLanguage() == "NO") {
      _rawData = await rootBundle.loadString("assets/data/words_no.csv");
    } else if (TTSController().getCurrentLanguage() == "US") {
      _rawData = await rootBundle.loadString("assets/data/words_en_US.csv");
    } else {
      _rawData = await rootBundle.loadString("assets/data/words_no.csv");
    }
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
    setState(() {
      dictionary = _listData.map((e) {
        return e[0].toString();
      }).toList();
    });
  }

  String getLastWord() {
    if (_controller.text.isNotEmpty) {
      List<String> words = _controller.text.split(" ");
      return words.last;
    } else {
      return (" ");
    }
  }

  List<String> _searchList(String searchKey) {
    List<String> hitList = [];
    for (String word in dictionary) {
      if (word.startsWith(searchKey.toLowerCase())) {
        hitList.add(word);
      }
    }

    if (dictionary.isEmpty || dictionary == null) {
      return dictionary;
    }

    if (hitList.isEmpty) {
      return dictionary.sublist(0, 8);
    } else {
      if (hitList.length < 8) {
        return hitList.sublist(0, hitList.length);
      } else {
        return hitList.sublist(0, 8);
      }
    }
  }

  void _toUpperCase() {
    for (int i = 0; i < firstRow.length; i++) {
      firstRow[i] = firstRow[i].toUpperCase();
    }
    for (int i = 0; i < secondRow.length; i++) {
      secondRow[i] = secondRow[i].toUpperCase();
    }
    for (int i = 0; i < thirdRow.length; i++) {
      thirdRow[i] = thirdRow[i].toUpperCase();
    }
    for (int i = 0; i < fourthRow.length; i++) {
      fourthRow[i] = fourthRow[i].toUpperCase();
    }
    for (int i = 0; i < fifthRow.length; i++) {
      fifthRow[i] = fifthRow[i].toUpperCase();
    }
    isUpperCase = true;
  }

  void _toLowerCase() {
    for (int i = 0; i < firstRow.length; i++) {
      firstRow[i] = firstRow[i].toLowerCase();
    }
    for (int i = 0; i < secondRow.length; i++) {
      secondRow[i] = secondRow[i].toLowerCase();
    }
    for (int i = 0; i < thirdRow.length; i++) {
      thirdRow[i] = thirdRow[i].toLowerCase();
    }
    for (int i = 0; i < fourthRow.length; i++) {
      fourthRow[i] = fourthRow[i].toLowerCase();
    }
    for (int i = 0; i < fifthRow.length; i++) {
      fifthRow[i] = fifthRow[i].toLowerCase();
    }
    isUpperCase = false;
  }
}
