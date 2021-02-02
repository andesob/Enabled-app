import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'main_page_button.dart';
import '../strings/strings.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkmode = false;

  void _changeText() {
    setState(() {
      darkmode = !darkmode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.apricot);
    Color appBarColorLight = Color(StaticColors.apricot);
    Color appBarColorDark = Color(StaticColors.melon);
    Color backgroundColor = Color(StaticColors.onyx);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: darkmode ? backgroundColor : Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
          child: GradientAppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
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
                      _changeText();
                    }),
              )
            ],
          ),
        ),
        body: GridView.count(
            shrinkWrap: true,
            crossAxisCount: isPortrait ? 2 : 3,
            children: <Widget>[
              MainPageButton(Strings.needs, darkmode),
              MainPageButton(Strings.custom, darkmode),
              MainPageButton(Strings.keyboard, darkmode),
              MainPageButton(Strings.contacts, darkmode),
              MainPageButton(Strings.smart, darkmode),
              MainPageButton(Strings.emergency, darkmode),
            ]),
      ),
    );
  }
}
