import 'package:enabled_app/custom_page/CustomPageButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'CustomCategory.dart';
import 'CustomPageButton.dart';

/*
//TODO Change strings to global string class
void main() {
  runApp(CustomPage());
}

class CustomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Custom page",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: Color(0xffffecd2), secondary: Color(0xfffcb7a0))),
      home: CustomPageHome(title: "dunde"),
    );
  }
}

 */

class CustomPageHome extends StatefulWidget {
  CustomPageHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomPageHome createState() => _CustomPageHome();
}

class _CustomPageHome extends State<CustomPageHome> {
  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // For testing purposes
    List<String> testObjects = ['1', '2', '3', '4', '5', '6'];
    final customCategory =
        CustomCategory(categoryName: "Eskil", objects: testObjects);

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
                gradient: LinearGradient(colors: [lightPeach, darkPeach]),
                actions: <Widget>[
                  Material(
                    type: MaterialType.transparency,
                  )
                ])),
        body: Container(
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView(shrinkWrap: true, children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Add more"))),
                  CustomVerticalList(
                    listTitle: "Eskil",
                    listObjects: customCategory,
                  ),
                  CustomVerticalList(
                    listTitle: "Dunde",
                    listObjects: customCategory,
                  ),
                  CustomVerticalList(
                    listTitle: "Dunde",
                    listObjects: customCategory,
                  ),
                  CustomVerticalList(
                    listTitle: "Dunde",
                    listObjects: customCategory,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomVerticalList extends StatelessWidget {
  CustomVerticalList({Key key, this.listTitle, this.listObjects})
      : super(key: key);

  final String listTitle;
  final CustomCategory listObjects;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(alignment: Alignment.topCenter, child: Text(this.listTitle)),
      Flexible(
          child: Container(
              //margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) /
                  4,
              //width: 800,
              color: Colors.black12,
              child: ListView(
                padding: EdgeInsets.all(0),
                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    children: [
                      for (var item in listObjects.objects)
                        Container(
                            height: MediaQuery.of(context).size.width * (0.285),
                            width: MediaQuery.of(context).size.width * (0.285),
                            child: CustomPageButton(item.toString()))
                    ],
                  )
                ],
              ))),
    ]);
  }
}
