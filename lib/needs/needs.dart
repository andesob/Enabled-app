import 'package:enabled_app/needs/NeedsCategory.dart';
import 'package:enabled_app/needs/NeedsVerticalList.dart';
import 'package:enabled_app/needs/needsPageButton.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:enabled_app/colors/colors.dart';

class NeedsPage extends StatefulWidget {
  NeedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends State<NeedsPage> {
  List<NeedsCategory> categoryList = [];
  List<NeedsVerticalList> verticalList = [];

  void initState() {
    super.initState();

    List<String> testObjects = ['1', '2', '3', '4', '5'];
    NeedsCategory needsCategory = new NeedsCategory();
    needsCategory.categoryName = 'Sundeersot123';
    needsCategory.categoryObjects = testObjects;

    for (var i = 0; i < 5; i++) {
      categoryList.add(needsCategory);
    }
    for (var item in categoryList) {
      NeedsVerticalList list = new NeedsVerticalList(
        categoryTitle: item.categoryName,
        buttonList: item.allButtons(),
      );
      verticalList.add(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final ItemScrollController itemScrollController = ItemScrollController();

    final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Container(
                // child: Align(
                // alignment: Alignment.centerRight,
                // child: FlatButton(
                // child: Text("Add more"),
                // onPressed: () {
                // showDialog(
                // context: context,
                // builder: (BuildContext context) {
                // return CustomPopup();
                // });
                // },
                // ))),
                Expanded(
                  child: ScrollablePositionedList.builder(
                      initialScrollIndex: 0,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: verticalList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => verticalList[index]),
                ),
                Center(
                  child: Row(
                    children: [
                      Container(
                        child: FlatButton(
                          child: new Text("Opp"),
                          onPressed: () {
                            //upCommand();
                          },
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          child: new Text("Ned"),
                          onPressed: () {
                            //downCommand();
                          },
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          child: new Text("Ok"),
                          onPressed: () {
                            //selectCommand();
                          },
                        ),
                      ),
                      //TODO Add back logic
                      Container(
                        child: FlatButton(
                          child: new Text("Tilbake"),
                          onPressed: () {
                            //backCommand();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
