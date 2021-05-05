import 'dart:io';

import 'package:enabled_app/mocking/mock_tts_controller.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TTSController controller = TTSController();
  MockTTSController mockController = MockTTSController();

  test("Empty language test", () async {
    var result = await controller.setLanguage("");
    expect(result, "Enter language");
  });

  test("Invalid language test", () async {
    var result = await controller.setLanguage("SWE");
    expect(result, "Language not found");
  });

  test("Valid language test", () async {
    when(mockController.setLanguage("NO")).thenAnswer((_) async => "NO language set");
    var result = await mockController.setLanguage("NO");
    expect(result, "NO language set");
  });

  test("Same TTSController instance", () {
    var result = TTSController();
    expect(result, TTSController());
  });

  test("Same FlutterTts instance", () {
    var result = TTSController().flutterTts;
    expect(result, TTSController().flutterTts);
  });

/*
  test("Invalid language test", (){

  });

  test("Invalid language test", (){

  });
  */
}
