import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:enabled_app/libraries/hue/main/bridge_api.dart';
import 'package:enabled_app/libraries/hue/main/hue_api.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart';

class SmartMainPage extends StatefulWidget {
  SmartMainPage({Key key, this.title}) : super(key: key);

  final String title;

  SmartMainPageState createState() => SmartMainPageState();
}

class SmartMainPageState extends PageState<SmartMainPage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);
  Color backgroundColor = Color(StaticColors.onyx);

  bool darkmode = false;

  List<HomePageButton> smartPageBtnList = [];

  @override
  void initState() {
    addDefaultButtons();
  }

  void _changeDarkmode() {
    setState(() {
      darkmode = !darkmode;
    });
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    bool useMobileLayout = shortestSide < 600;
    double leftRightPadding = MediaQuery.of(context).size.width / 5;
    HueApi api = new HueApi();
    api.findBridge();

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.fromLTRB(leftRightPadding, 0, leftRightPadding, 0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: useMobileLayout ? 1 : smartPageBtnList.length,
              children: smartPageBtnList.cast<Widget>(),
            ),
          ),
        ],
      ),
    );
  }

  void addDefaultButtons() {
    smartPageBtnList.add(HomePageButton(text: Strings.chromecast));
    smartPageBtnList.add(HomePageButton(text: Strings.hue));
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
