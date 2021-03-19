import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/contacts_page/contact_popup.dart';
import 'package:enabled_app/libraries/hue/main/hue_api.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/philips_hue/hue_button.dart';
import 'package:enabled_app/philips_hue/hue_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HuePage extends StatefulWidget {
  HuePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HuePageState();
}

class _HuePageState extends PageState<HuePage> {
  bool isLightOn;

  @override
  void initState() {
    super.initState();
    isLightOn = initLightState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        isLightOn
            ? HuePageButton(
          text: "On",
          onClick: powerOff,
        )
            : HuePageButton(
          text: "Off",
          onClick: powerOn,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HuePageButton(
              text: "Dim",
              onClick: brightnessDown,
            ),
            HuePageButton(
              text: "Brighten",
              onClick: brightnessUp,
            ),
          ],
        ),
        HueDropdown(onClick: changeScene,),
      ],
    );
  }

  bool initLightState() {
    HueApi api = new HueApi();
    return api.groups.first.state.allOn;
  }

  void brightnessUp(){
    HueApi api = new HueApi();
    api.brightnessUp();
  }

  void brightnessDown(){
    HueApi api = new HueApi();
    api.brightnessDown();
  }

  void powerOn() {
    HueApi api = new HueApi();

    api.powerOnAll();

    setState(() {
      isLightOn = true;
    });
  }

  void powerOff() {
    HueApi api = new HueApi();

    api.powerOffAll();

    setState(() {
      isLightOn = false;
    });
  }

  void changeScene(String sceneId){
    HueApi api = new HueApi();

    api.changeScene(sceneId);
  }

  @override
  void leftPressed() {
    // TODO: implement leftPressed
  }

  @override
  void pullPressed() {
    // TODO: implement pullPressed
  }

  @override
  void pushPressed() {
    // TODO: implement pushPressed
  }

  @override
  void rightPressed() {
    // TODO: implement rightPressed
  }
}
