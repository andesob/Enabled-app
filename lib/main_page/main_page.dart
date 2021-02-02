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
  bool sunde = false;

  void _changeText() {
    setState(() {
      sunde = !sunde;
      print(sunde);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            gradient: LinearGradient(colors: [lightPeach, darkPeach]),
            actions: <Widget>[
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                    icon: Icon(Icons.accessible_forward),
                    highlightColor: Color(0xFFFFFF),
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
              MainPageButton(Strings.needs),
              MainPageButton(Strings.custom),
              MainPageButton(Strings.keyboard),
              MainPageButton(Strings.contacts),
              MainPageButton(Strings.smart),
              MainPageButton(Strings.emergency),
            ]),
      ),
    );
  }
}