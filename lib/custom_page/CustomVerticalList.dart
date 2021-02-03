import 'package:enabled_app/custom_page/CustomCategory.dart';
import 'package:enabled_app/custom_page/CustomPageButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//TODO Find a solution to the "buggy" behavior on the last scrolls in the scrollable position list
class CustomVerticalList extends StatelessWidget {
  CustomVerticalList({Key key, this.listTitle, this.listObjects})
      : super(key: key);

  String listTitle;
  CustomCategory listObjects;
  int listIndex = 0;

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  getScrollController() {
    return itemScrollController;
  }

  scrollRight() {
    if (listIndex < listObjects.objects.length) {
      listIndex++;
      itemScrollController.scrollTo(
          index: listIndex,
          duration: Duration(
            seconds: 1,
          ),
          alignment: 0);
    }
  }

  scrollLeft() {
    if (listIndex > 0) {
      listIndex--;
      itemScrollController.scrollTo(
          index: listIndex,
          duration: Duration(
            seconds: 1,
          ),
          alignment: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(alignment: Alignment.topCenter, child: Text(this.listTitle)),
      Flexible(
          child: Container(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) /
                  6,
              //width: 800,
              color: Colors.black12,
              child: ScrollablePositionedList.builder(
                  initialScrollIndex: 0,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: listObjects.objects.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Row(
                        children: [
                          // for (var item in listObjects.objects)
                          Container(
                              height:
                                  MediaQuery.of(context).size.width * (0.285),
                              width:
                                  MediaQuery.of(context).size.width * (0.285),
                              child: CustomPageButton(
                                  listObjects.objects[index].toString()))
                        ],
                      )))),
    ]);
  }
}
