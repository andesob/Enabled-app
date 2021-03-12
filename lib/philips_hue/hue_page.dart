import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/contacts/contact_popup.dart';
import 'package:enabled_app/libraries/hue/main/hue_api.dart';
import 'package:enabled_app/main_page/main_page_button.dart';
import 'package:enabled_app/philips_hue/hue_button.dart';
import 'package:enabled_app/philips_hue/hue_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HuePageState();
}

class _HuePageState extends State<HuePage> {
  bool isLightOn;

  @override
  void initState() {
    super.initState();
    isLightOn = initLightState();
  }

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    HueApi api = new HueApi();

    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 1.0],
              colors: [lightPeach, darkPeach])),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
          child: GradientAppBar(
            title: Text("Hue Page"),
            gradient: LinearGradient(colors: [lightPeach, darkPeach]),
          ),
        ),
        body: Column(
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(StaticColors.lighterSlateGray),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward),
              label: 'Up',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_downward),
              label: 'Down',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Send',
            ),
          ],
        ),
      ),
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
}
