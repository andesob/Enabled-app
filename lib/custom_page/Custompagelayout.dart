import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'CustomCategory.dart';

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

    // For testing purposes
    List<String> testObjects = ['1', '2', '3', '4'];
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
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: [lightPeach, darkPeach]),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(padding: EdgeInsets.all(20), child: Text("Add more")),
              Flexible(
                child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    children: <Widget>[
                      CustomVerticalList(
                        listTitle: "Eskil",
                        listObjects: customCategory,
                      ),
                      CustomVerticalList(
                        listTitle: "Dunde",
                        listObjects: customCategory,
                      ),
                      Text("2"),
                      Text("3"),
                      Text("4"),
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
      Text(this.listTitle),
      Flexible(
          child: ListView(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(20.0),
              height: 10,
              width: 800,
              color: Colors.amber,
              child: Row(
                children: [
                  for (var item in listObjects.objects)
                    Container(
                      margin: EdgeInsets.all(15),
                      height: 100,
                      color: Colors.black12,
                      child: Text("Eskils pytt i panne"),
                    )
                ],
              )),
        ],
      )),
    ]);
  }
}
