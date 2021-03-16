import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/emergency_page/emergency_button.dart';
import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:enabled_app/main_layout/button_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'main_page_button.dart';
import '../strings/strings.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends PageState<MyHomePage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);
  Color backgroundColor = Color(StaticColors.onyx);

  bool darkmode = false;

  int horizontalBtns;
  int verticalBtns;

  List<int> currPos = [0, 0];
  int currXPos = 0;
  int currYPos = 0;
  int pos = 0;

  List<MainPageButton> mainPageBtnList = [];
  var list;

  @override
  void initState() {
    super.initState();
    addDefaultButtons();
  }

  void addDefaultButtons() {
    mainPageBtnList.add(MainPageButton(text: Strings.needs));
    mainPageBtnList.add(MainPageButton(text: Strings.custom));
    mainPageBtnList.add(MainPageButton(text: Strings.keyboard));
    mainPageBtnList.add(MainPageButton(text: Strings.contacts));
    mainPageBtnList.add(MainPageButton(text: Strings.smart));
    mainPageBtnList.add(EmergencyButton(text: Strings.emergency));
  }

  void _changeDarkmode() {
    setState(() {
      darkmode = !darkmode;
    });
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
          list[i][j] = mainPageBtnList[index];
          index++;
        }
      }
    });
  }

  @override
  void leftPressed() {
    removeAllFocus();
    currPos[1] == verticalBtns - 1 ? currPos[1] = 0 : currPos[1]++;
    list[currPos[1]][currPos[0]].state.setFocus();
  }

  @override
  void pullPressed() {
    // TODO: implement pullPressed
  }

  @override
  void rightPressed() {
    removeAllFocus();
    currPos[0] == horizontalBtns - 1 ? currPos[0] = 0 : currPos[0]++;
    list[currPos[1]][currPos[0]].state.setFocus();
  }

  @override
  void pushPressed() {
    list[currPos[1]][currPos[0]].state.pushPressed();
  }

  void removeAllFocus() {
    for (int i = 0; i < mainPageBtnList.length; i++) {
      mainPageBtnList[i].state.removeFocus();
    }
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
            children: mainPageBtnList.cast<Widget>(),
          ),
        ],
      ),
    );
  }
}
