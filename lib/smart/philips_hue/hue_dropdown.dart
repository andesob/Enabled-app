import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/smart/hue/hue_api.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:hue_dart/hue_dart.dart';

// TODO Change the flatButton to raisedButton??
class HueDropdown extends StatefulWidget {
  HueDropdown({Key key}) : super(key: key);

  bool isFocused = false;
  _HueDropdown state;

  @override
  _HueDropdown createState() {
    state = _HueDropdown();
    return state;
  }
}

class _HueDropdown extends State<HueDropdown> {
  String text;

  HueApi api = new HueApi();

  Scene dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dropdownValue = api.scenes.first;
  }
  /// Sets the focus the button to true
  void setFocus() {
    if (this.mounted) {
      setState(() {
        widget.isFocused = true;
      });
    } else {
      print("not mounted");
    }
  }

  /// Removes the focus of the button.
  void removeFocus() {
    setState(() {
      widget.isFocused = false;
    });
  }

  void changeValue(){

  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * (0.7),
      height: MediaQuery.of(context).size.width * (0.35),
      child: DropdownButton<Scene>(
        value: dropdownValue,
        icon: Align(child: Icon(Icons.arrow_drop_down), alignment: Alignment.centerRight,),
        iconSize: 24,
        style: TextStyle(color: Color(StaticColors.charcoal)),
        underline: Container(
          color: Color(StaticColors.charcoal),
        ),
        onChanged: (Scene newValue) {
          setState(() {
            dropdownValue = newValue;
            api.changeScene(dropdownValue.id, api.currentGroup.id.toString());
          });
        },
        items: api.scenes.map<DropdownMenuItem<Scene>>((Scene value){
          return DropdownMenuItem<Scene>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        ),
    );
  }
}
