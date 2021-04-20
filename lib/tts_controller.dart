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

  String setLanguage(String lang){
    switch(lang){
      case "NO":
        flutterTts.setVoice({"name": "nb-NO-language", "locale": "nb-NO"});
        return lang + " language set";
        break;
      case "GB":
        flutterTts.setVoice({"name": "en-GB-language", "locale": "en-GB"});
        return lang + " language set";
        break;
      case "":
        return "Enter language";
      default:
        return "Language not found";
    }
  }
}