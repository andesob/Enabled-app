import 'package:enabled_app/needs/needsPageButton.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
  runApp(Needs());
}

class Needs extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: Color(0xffffecd2), secondary: Color(0xfffcb7a0))),
      home: NeedsPage(title: 'Contacts'),
    );
  }
}

class NeedsPage extends StatefulWidget {
  NeedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends State<NeedsPage> {
  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.0, 1.0],
                colors: [lightPeach, darkPeach])),
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
              child: GradientAppBar(
                  gradient: LinearGradient(colors: [lightPeach, darkPeach]),
                  actions: <Widget>[
                    Material(
                      type: MaterialType.transparency,
                    )
                  ])),
          body: GridView.count(
            crossAxisCount: isPortrait ? 3:4,
            children: <Widget>[
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
              NeedsPageButton('WALLA'),
            ],
          ),
        ));
  }
}
