import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/libraries/hue/main/hue_api.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

// TODO Change the flatButton to raisedButton??
class HueDropdown extends StatefulWidget {
  HueDropdown({
    Key key,
    this.onClick,
    this.isFocused = false,
  }) : super(key: key);

  final ValueSetter<String> onClick;
  final bool isFocused;

  @override
  _HueDropdownState createState() => _HueDropdownState();
}

class _HueDropdownState extends State<HueDropdown> {
  String text;
  int dropdownValue = 1;
  HueApi api = new HueApi();

  @override
  void initState() {
    super.initState();
    api = new HueApi();
  }

  @override
  Widget build(BuildContext context) {
    HueApi api = new HueApi();

    return Container(
      color: Color(widget.isFocused
          ? StaticColors.deepSpaceSparkle
          : StaticColors.lighterSlateGray),
      padding: EdgeInsets.all(10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isDense: true,
          dropdownColor: Color(StaticColors.lighterSlateGray),
          value: dropdownValue,
          icon: Align(
            child: Icon(
              Icons.arrow_drop_down,
              color: Color(StaticColors.apricot),
            ),
            alignment: Alignment.centerRight,
          ),
          iconSize: 24,
          style: TextStyle(
            color: Color(StaticColors.apricot),
            fontWeight: FontWeight.bold,
          ),
          onChanged: (int newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: new List<DropdownMenuItem<int>>.generate(
            api.scenes.length,
            (int index) => new DropdownMenuItem<int>(
                value: index,
                child: new Text(
                  api.scenes[index].name,
                ),
                onTap: () {
                  widget.onClick?.call(api.scenes[index].id);
                }),
          ),
        ),
      ),
    );
  }
}
