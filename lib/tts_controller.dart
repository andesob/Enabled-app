import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

//Controller class to make sure the same text-to-speech instance is used in the entire app
class TTSController {
  static final TTSController _ttsController = TTSController._internal();
  final FlutterTts _flutterTts = FlutterTts();

  factory TTSController() {
    return _ttsController;
  }

  TTSController._internal();

  FlutterTts get flutterTts => _flutterTts;

  Future<String> setLanguage(String lang) async {
    switch(lang){
      case "NO":
        if(Platform.isAndroid)await flutterTts.setLanguage("nb-NO");
        if(Platform.isIOS)await flutterTts.setLanguage("no-NO");
        return lang + " language set";
        break;
      case "US":
        await flutterTts.setLanguage("en-US");
        return lang + " language set";
        break;
      case "":
        return "Enter language";
      default:
        return "Language not found";
    }
  }
}
