import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/main_page/main_page_button.dart';
import 'package:enabled_app/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

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
    // TODO: implement build
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
          child: new ListView(
            children: <Widget>[
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: smartPageBtnList.cast<Widget>(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                    },
                    child: Text(Strings.down),
                    color: Color(StaticColors.lighterSlateGray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                    },
                    child: Text(Strings.right),
                    color: Color(StaticColors.lighterSlateGray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
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
