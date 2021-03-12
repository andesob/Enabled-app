import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/libraries/hue/main/bridge_api.dart';
import 'package:enabled_app/main_page/main_page_button.dart';
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

class SmartMainPageState extends State<SmartMainPage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);
  Color backgroundColor = Color(StaticColors.onyx);

  bool darkmode = false;

  List<MainPageButton> smartPageBtnList = [];

  @override
  void initState() {
    // TODO: implement initState
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
    //HueApi api = new HueApi();
    BridgeApi api = BridgeApi(new Client(), "192.168.100.38");

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: darkmode ? backgroundColor : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.07
                  : MediaQuery.of(context).size.height * 0.1),
          child: GradientAppBar(
            gradient:
                LinearGradient(colors: [appBarColorLight, appBarColorDark]),
            actions: <Widget>[
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                    icon: Icon(Icons.accessible_forward),
                    color: Color(
                        darkmode ? StaticColors.black : StaticColors.white),
                    splashColor: Color(Colors.grey.value),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _changeDarkmode();
                    }),
              )
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(
                      leftRightPadding, 0, leftRightPadding, 0),
                  child: GridView.count(

                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: useMobileLayout ? 1 : smartPageBtnList.length,
                    children: smartPageBtnList.cast<Widget>(),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        //api.changeColors(1, 0.1, 0.1);
                        //api.powerOnAll();
                        //api.brightnessDown();
                      },
                      child: Text("Pink"),
                      color: Color(StaticColors.lighterSlateGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        //api.changeColors(0, 1, 0.5);
                        //api.getScenes();
                        //api.getGroups();
                        //api.changeScene("NoDii0A1l6pDsqt", "1");
                        //api.powerOffAll();
                        //api.brightnessUp();

                        api.update();

                      },
                      child: Text("Green"),
                      color: Color(StaticColors.lighterSlateGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        api.lights();
                      },
                      child: Text(Strings.enter),
                      color: Color(StaticColors.lighterSlateGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  void addDefaultButtons() {
    smartPageBtnList.add(MainPageButton(text: Strings.chromecast));
    smartPageBtnList.add(MainPageButton(text: Strings.hue));
  }
}
