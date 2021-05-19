import 'dart:io' show Platform;
import 'package:flutter_tts/flutter_tts.dart';

/// TTSController makes sure the same text-to-speech instance is used in th entire app.
//Controller class to make sure the same text-to-speech instance is used in the entire app
class TTSController {
  /// The singleton instance for the TTSController.
  static final TTSController _ttsController = TTSController._internal();
  final FlutterTts _flutterTts = FlutterTts();
  String _currentLanguage = "US";

  /// Creates the singleton instance.
  factory TTSController() {
    return _ttsController;
  }

  TTSController._internal();

  FlutterTts get flutterTts => _flutterTts;

  /// Sets the language for the text-to-speech controller. Can either
  /// be norwegian or english.
  Future<String> setLanguage(String lang) async {
    switch (lang) {
      case "NO":
        _currentLanguage = lang;
        if (Platform.isAndroid) await flutterTts.setLanguage("nb-NO");
        if (Platform.isIOS) await flutterTts.setLanguage("no-NO");
        return lang + " language set";
        break;
      case "US":
        _currentLanguage = lang;
        await flutterTts.setLanguage("en-US");
        return lang + " language set";
        break;
      case "":
        return "Enter language";
      default:
        return "Language not found";
    }
  }

  /// Toggles the language between Norwegian and English.
  Future<String> changeLanguage() async {
    if (_currentLanguage == "US") {
      return await setLanguage("NO");
    } else {
      return await setLanguage("US");
    }
  }

  /// Returns the currently used language for the text controller.
  String getCurrentLanguage() {
    return _currentLanguage;
  }
}
