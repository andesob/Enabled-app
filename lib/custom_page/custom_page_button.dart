import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gradient_text/gradient_text.dart';

// TODO Change the flatButton to raisedButton??
class CustomPageButton extends StatefulWidget {
  CustomPageButton({
    Key key,
    this.text,
    this.isFocused = false,
  }) : super(key: key);

  final String text;
  final bool isFocused;

  @override
  _CustomPageButton createState() => _CustomPageButton();
}

class _CustomPageButton extends State<CustomPageButton> {
  FlutterTts flutterTts = TTSController().flutterTts;

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      padding: EdgeInsets.all(5),
      child: RaisedButton(
        highlightColor: Color(StaticColors.deepSpaceSparkle),
        color: widget.isFocused
            ? Color(StaticColors.deepSpaceSparkle)
            : Color(StaticColors.lighterSlateGray),
        elevation: widget.isFocused ? 10 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.all(0.0),
        child: new GradientText(
          widget.text,
          style: TextStyle(
            fontSize: 12,
          ),
          gradient: new LinearGradient(
            colors: [lightPeach, darkPeach],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        onPressed: () {
          getVoices();
          flutterTts.setVoice({"name": "nb-NO-language", "locale": "nb-NO"});
          flutterTts.speak(widget.text);
        },
      ),
    );
  }

  Future<void> getVoices() async {
    var voices = await flutterTts.getVoices;

    for (var v in voices) {
      print(v);
    }
  }
}
