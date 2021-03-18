import 'package:enabled_app/main_layout/button_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/needs/needs_category.dart';
import 'package:enabled_app/needs/needs_vertical_list.dart';
import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:enabled_app/page_state.dart';
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

class _NeedsPageState extends PageState<NeedsPage> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ScrollablePositionedList.builder(
                initialScrollIndex: 0,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: verticalList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => verticalList[index]),
          ),
        ],
      ),
    );
  }

  @override
  void leftPressed() {
    // TODO: implement leftPressed
  }

  @override
  void pullPressed() {
    // TODO: implement pullPressed
  }

  @override
  void pushPressed() {
    // TODO: implement pushPressed
  }

  @override
  void rightPressed() {
    // TODO: implement rightPressed
  }
}
