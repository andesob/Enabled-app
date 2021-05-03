import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/contacts_page/contact_popup.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/philips_hue/hue_api.dart';
import 'package:enabled_app/philips_hue/hue_button.dart';
import 'package:enabled_app/philips_hue/hue_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart';

class HuePage extends StatefulWidget {
  HuePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HuePageState();
}

class _HuePageState extends PageState<HuePage> {
  bool isLightOn;
  bool isDropdownExpanded;
  HueApi api;
  int verticalListIndex;

  @override
  void initState() {
    super.initState();
    isDropdownExpanded = false;
    verticalListIndex = 0;
    api = new HueApi(new Client());
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
                isFocused: verticalListIndex == 0,
              )
            : HuePageButton(
                text: "Off",
                onClick: powerOn,
                isFocused: verticalListIndex == 0,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HuePageButton(
              text: "Dim",
              onClick: brightnessDown,
              isFocused: verticalListIndex == 1,
            ),
            HuePageButton(
              text: "Brighten",
              onClick: brightnessUp,
              isFocused: verticalListIndex == 2,
            ),
          ],
        ),
        HueDropdown(
          onClick: changeScene,
          isFocused: verticalListIndex == 3,
        ),
      ],
    );
  }

  bool initLightState() {
    if (api.groups != null) {
      return api.groups.first.state.allOn;
    }
    return false;
  }

  void brightnessUp() {
    api.brightnessUp();
  }

  void brightnessDown() {
    api.brightnessDown();
  }

  void powerOn() {
    api.powerOnAll();

    setState(() {
      isLightOn = true;
    });
  }

  void powerOff() {
    api.powerOffAll();

    setState(() {
      isLightOn = false;
    });
  }

  void changeScene(String sceneId) {
    api.changeScene(sceneId);
  }

  void _goUp() {
    setState(() {
      verticalListIndex--;
    });
  }

  void _goDown() {
    setState(() {
      verticalListIndex++;
    });
  }

  @override
  void leftPressed() {
    if (verticalListIndex > 0) _goUp();
  }

  @override
  void rightPressed() {
    if (verticalListIndex < 3) _goDown();
  }

  @override
  void pullPressed() {
    Navigator.pushReplacementNamed(context, Strings.SMART);
  }

  @override
  void pushPressed() {
    setState(() {
      switch (verticalListIndex) {
        case 0:
          if (isLightOn) {
            powerOff();
          } else {
            powerOn();
          }
          break;
        case 1:
          brightnessDown();
          break;
        case 2:
          api.brightnessUp();
          break;
      }
    });
  }
}
