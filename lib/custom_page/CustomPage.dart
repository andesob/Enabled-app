import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/custom_page/CustomCategory.dart';
import 'package:enabled_app/custom_page/CustomPageButton.dart';
import 'package:enabled_app/custom_page/CustomVerticalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//TODO Find a solution to the "buggy" behavior on the last scrolls in the scrollable position list.

class CustomPageHome extends StatefulWidget {
  CustomPageHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomPageHome createState() => _CustomPageHome();
}

class _CustomPageHome extends State<CustomPageHome> {
  List<CustomCategory> categoryList = [];
  List<CustomVerticalList> verticalList = [];
  int verticalListIndex = 0;
  ItemScrollController childController;
  bool inChildLevel = false;

  // TODO remove test objects.
  @override
  void initState() {
    super.initState();

    // For testing purposes
    List<String> testObjects = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    CustomCategory customCategory = new CustomCategory();
    customCategory.categoryName = "Eskil";
    customCategory.objects = testObjects;

    for (var i = 0; i < 7; i++) {
      categoryList.add(customCategory);
    }

    for (var item in categoryList) {
      CustomVerticalList list = new CustomVerticalList();
      list.listTitle = item.categoryName;
      list.listObjects = item;
      verticalList.add(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    /// Controller to scroll or jump to a particular item.
    final ItemScrollController itemScrollController = ItemScrollController();

    /// Listener that reports the position of items when the list is scrolled.
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    // For testing purposes
    List<String> testObjects = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
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
                child: ScrollablePositionedList.builder(
                    initialScrollIndex: 0,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    itemCount: verticalList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => verticalList[index]

                    //verticalList.cast<Widget>()
                    /*  Container(
                      margin: EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Add more"))),

                 */
                    ),
              ),
              //TODO mark the box or list in focus.
              Center(
                  child: Row(
                children: [
                  Container(
                    child: FlatButton(
                      child: new Text("Opp"),
                      onPressed: () {
                        if (!inChildLevel) {
                          if (verticalListIndex > 0) {
                            verticalListIndex--;
                            itemScrollController.scrollTo(
                                index: verticalListIndex,
                                duration: Duration(
                                  seconds: 1,
                                ),
                                alignment: 0);
                          }
                        } else if (inChildLevel) {
                          verticalList[verticalListIndex].scrollLeft();
                        }
                      },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: new Text("Ned"),
                      onPressed: () {
                        if (!inChildLevel) {
                          verticalListIndex++;
                          itemScrollController.scrollTo(
                              index: verticalListIndex,
                              duration: Duration(
                                seconds: 1,
                              ),
                              alignment: 0);
                        } else if (inChildLevel) {
                          verticalList[verticalListIndex].scrollRight();
                        }
                      },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: new Text("Ok"),
                      onPressed: () {
                        inChildLevel = true;
                      },
                    ),
                  ),
                  //TODO Add back logic
                  Container(
                    child: FlatButton(
                      child: new Text("Tilbake"),
                      onPressed: () {
                        inChildLevel = false;
                      },
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
