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
}
