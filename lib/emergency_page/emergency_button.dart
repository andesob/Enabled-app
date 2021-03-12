import 'dart:ui';

import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/emergency_page/emergency_alert.dart';

import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:enabled_app/main_page/main_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gradient_text/gradient_text.dart';

class EmergencyButton extends MainPageButton{
  String text;
  bool darkmode = false;
  bool focused = false;
  MainPageButtonState state;

  EmergencyButton({Key key, this.text}) : super(key: key);

  @override
  MainPageButtonState createState() {
    state = EmergencyButtonState();
    return state;
  }
}

class EmergencyButtonState extends MainPageButtonState {

  @override
  buttonPressed(context) {
    _launchURL(StaticEmergencyContact.emergencyContact);
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);

    return Container(
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(widget.focused
            ? StaticColors.deepSpaceSparkle
            : StaticColors.lighterSlateGray),
      ),
      child: FlatButton(
        child: new GradientText(
          widget.text,
          style: TextStyle(
            color: Color(
                widget.darkmode ? StaticColors.black : StaticColors.white),
          ),
          gradient: new LinearGradient(
            colors: [lightPeach, darkPeach],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
        onPressed: () {
          _launchURL(StaticEmergencyContact.emergencyContact);
        },
      ),
    );
  } 
  _launchURL(number) async {
    if(number != null) {
      bool res = await FlutterPhoneDirectCaller.callNumber(number);
    }
    else{
      showEmergencyContactAlert();
    }
  }

  showEmergencyContactAlert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmergencyAlert();
      },
    );
  }
}