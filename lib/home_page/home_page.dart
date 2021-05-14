import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/emergency_page/emergency_alert.dart';
import 'package:enabled_app/emergency_page/emergency_button.dart';
import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:enabled_app/main_layout/input_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page_button.dart';
import '../global_data/strings.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends PageState<MyHomePage> {
  SharedPreferences prefs;
  int horizontalBtns;
  int verticalBtns;

  List<int> currPos = [0, 0];
  String currBtnString = Strings.NEEDS;

  List<HomePageButton> mainPageBtnList = [];
  List<String> btnTextList = [
    Strings.NEEDS,
    Strings.CUSTOM,
    Strings.KEYBOARD,
    Strings.CONTACTS,
    Strings.SMART,
    Strings.EMERGENCY,
  ];
  var list;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    String contact = prefs.getString("emergency");
    EmergencyContact.emergencyContact = contact;
  }

  void setGridSize(useMobileLayout) {
    setState(() {
      horizontalBtns = useMobileLayout ? 2 : 3;
      verticalBtns = useMobileLayout ? 3 : 2;
      list = List.generate(verticalBtns, (i) => List(horizontalBtns),
          growable: false);

      int index = 0;
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i].length; j++) {
          list[i][j] = btnTextList[index];
          index++;
        }
      }
    });
  }

  @override
  void leftPressed() {
    setState(() {
      currPos[1] == verticalBtns - 1 ? currPos[1] = 0 : currPos[1]++;
      currBtnString = list[currPos[1]][currPos[0]];
    });
  }

  @override
  void pullPressed() {}

  @override
  void rightPressed() {
    setState(() {
      currPos[0] == horizontalBtns - 1 ? currPos[0] = 0 : currPos[0]++;
      currBtnString = list[currPos[1]][currPos[0]];
    });
  }

  @override
  void pushPressed() {
    if (currBtnString == Strings.EMERGENCY) {
      _launchURL();
      return;
    }
    Navigator.pushReplacementNamed(context, currBtnString);
  }

  _launchURL() async {
    String number = EmergencyContact.emergencyContact;
    if (number != null && number.isNotEmpty) {
      bool res = await FlutterPhoneDirectCaller.callNumber(number);
    } else {
      showEmergencyContactAlert();
    }
  }

  showEmergencyContactAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmergencyAlert();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    bool useMobileLayout = shortestSide < 600;

    setGridSize(useMobileLayout);

    if (useMobileLayout) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]);
    }

    return _buildLayout(useMobileLayout);
  }

  Widget _buildLayout(useMobileLayout) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: new ListView(
        children: <Widget>[
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: useMobileLayout ? 2 : 3,
            children: btnTextList.map((string) {
              if (string == Strings.EMERGENCY) {
                return EmergencyButton(
                  text: string,
                  focused: currBtnString == string,
                  onPressed: _launchURL,
                );
              }
              return HomePageButton(
                text: string,
                focused: currBtnString == string,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
